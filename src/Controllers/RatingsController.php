<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Config\StoreCatalog;
use App\Events\RatingEventDispatcher;
use App\Http\Request;
use App\Http\Response;
use App\Repositories\ProductRepository;
use App\Repositories\RatingRepository;
use App\Security\ModerationAuth;
use App\Validation\SchemaValidator;
use PDOException;

/**
 * REST handlers for /api/ratings/*.
 */
final class RatingsController
{
    public function __construct(
        private readonly RatingRepository $ratings,
        private readonly ProductRepository $products,
        private readonly SchemaValidator $validator,
        private readonly RatingEventDispatcher $events,
    ) {
    }

    /** GET approved ratings, distribution, and average for a store/product. */
    public function listForProduct(Request $request): Response
    {
        $store = $request->getAttribute('store', '');
        $productId = $request->getAttribute('productId', '');
        if (!self::isValidStoreId($store)) {
            return $this->invalidRequest('Invalid store id', ['store' => $store]);
        }
        if (!self::isValidProductId($productId)) {
            return $this->invalidRequest('Invalid product id', ['productId' => $productId]);
        }
        if (!$this->products->exists($productId)) {
            return Response::jsonError(
                [
                    'code' => 'PRODUCT_NOT_FOUND',
                    'message' => 'Product not found',
                    'details' => ['productId' => $productId],
                ],
                404,
            );
        }

        $rows = $this->ratings->listApprovedForStoreAndProduct($store, $productId);
        $distribution = $this->ratings->distributionForStoreAndProduct($store, $productId);
        $avg = $this->ratings->averageStarsForStoreAndProduct($store, $productId);

        $ratings = [];
        foreach ($rows as $row) {
            $ratings[] = [
                'id' => (int) $row['id'],
                'star' => (int) $row['star'],
                'text' => $row['text'],
                'author' => $row['author'],
                'created' => self::formatDateTime($row['created_at']),
            ];
        }

        return Response::jsonOk([
            'ratings' => $ratings,
            'distribution' => $distribution,
            'stars' => $avg !== null ? $avg : 0.0,
        ]);
    }

    /** POST new PENDING rating with optional source query param. */
    public function create(Request $request): Response
    {
        $store = $request->getAttribute('store', '');
        $productId = $request->getAttribute('productId', '');
        if (!self::isValidStoreId($store)) {
            return $this->invalidRequest('Invalid store id', ['store' => $store]);
        }
        if (!self::isValidProductId($productId)) {
            return $this->invalidRequest('Invalid product id', ['productId' => $productId]);
        }
        if (!$this->products->exists($productId)) {
            return Response::jsonError(
                [
                    'code' => 'PRODUCT_NOT_FOUND',
                    'message' => 'Product not found',
                    'details' => ['productId' => $productId],
                ],
                404,
            );
        }

        $parsed = $this->decodeJsonBody($request->getBody());
        if ($parsed instanceof Response) {
            return $parsed;
        }
        $errors = $this->validator->validate($parsed, 'post-rating.schema.json');
        if ($errors !== []) {
            return $this->invalidRequest('Validation failed', ['errors' => $errors]);
        }

        $sourceRaw = $request->getQuery()['source'] ?? null;
        $source = self::normalizeSource($sourceRaw);
        if ($sourceRaw !== null && $sourceRaw !== '' && $source === null) {
            return $this->invalidRequest('Invalid source query parameter', ['source' => $sourceRaw]);
        }

        try {
            $id = $this->ratings->insertPending(
                $productId,
                $store,
                (int) $parsed['rating'],
                (string) $parsed['author'],
                (string) $parsed['text'],
                (string) $parsed['email'],
                $source,
            );
        } catch (PDOException) {
            return Response::jsonError(
                [
                    'code' => 'INVALID_REQUEST',
                    'message' => 'Could not create rating',
                    'details' => [],
                ],
                400,
            );
        }

        $this->events->dispatch(RatingEventDispatcher::CREATED, [
            'ratingId' => $id,
            'productId' => $productId,
            'originStore' => $store,
        ]);

        return Response::jsonOk(
            [
                'id' => $id,
                'status' => 'PENDING',
            ],
            201,
        );
    }

    /** Moderation: approve with optional criteria and optional store scope. */
    public function approve(Request $request): Response
    {
        $auth = ModerationAuth::requireModerator($request);
        if ($auth !== null) {
            return $auth;
        }

        $id = (int) $request->getAttribute('ratingId', '0');
        if ($id < 1) {
            return $this->invalidRequest('Invalid rating id', ['id' => $id]);
        }

        $row = $this->ratings->findById($id);
        if ($row === null) {
            return $this->ratingNotFound($id);
        }
        if ($row['status'] !== 'PENDING') {
            return $this->invalidRequest('Rating is not pending', ['status' => $row['status']]);
        }

        $parsed = $this->decodeJsonBody($request->getBody());
        if ($parsed instanceof Response) {
            return $parsed;
        }
        $errors = $this->validator->validate($parsed, 'post-approve.schema.json');
        if ($errors !== []) {
            return $this->invalidRequest('Validation failed', ['errors' => $errors]);
        }

        /** @var list<int> $criteria */
        $criteria = array_map('intval', $parsed['criteria'] ?? []);
        if (!$this->ratings->criteriaExist($criteria)) {
            return $this->invalidRequest('Unknown criteria id(s)', ['criteria' => $criteria]);
        }

        $storeIds = null;
        if (array_key_exists('store_ids', $parsed)) {
            /** @var list<string> $storeIds */
            $storeIds = array_values(array_map('strval', $parsed['store_ids']));
        }
        $resolvedStores = $storeIds ?? StoreCatalog::all();

        try {
            $this->ratings->approve($id, $criteria, $storeIds);
        } catch (\InvalidArgumentException $e) {
            return $this->invalidRequest($e->getMessage(), []);
        } catch (PDOException) {
            return Response::jsonError(
                [
                    'code' => 'INVALID_REQUEST',
                    'message' => 'Could not approve rating',
                    'details' => [],
                ],
                400,
            );
        }

        $this->events->dispatch(RatingEventDispatcher::APPROVED, [
            'ratingId' => $id,
            'criteria' => $criteria,
            'storeScope' => $resolvedStores,
        ]);

        return Response::jsonOk(['id' => $id, 'status' => 'APPROVED']);
    }

    /** Moderation: reject with mandatory reason id. */
    public function reject(Request $request): Response
    {
        $auth = ModerationAuth::requireModerator($request);
        if ($auth !== null) {
            return $auth;
        }

        $id = (int) $request->getAttribute('ratingId', '0');
        if ($id < 1) {
            return $this->invalidRequest('Invalid rating id', ['id' => $id]);
        }

        $row = $this->ratings->findById($id);
        if ($row === null) {
            return $this->ratingNotFound($id);
        }
        if ($row['status'] !== 'PENDING') {
            return $this->invalidRequest('Rating is not pending', ['status' => $row['status']]);
        }

        $parsed = $this->decodeJsonBody($request->getBody());
        if ($parsed instanceof Response) {
            return $parsed;
        }
        $errors = $this->validator->validate($parsed, 'post-reject.schema.json');
        if ($errors !== []) {
            return $this->invalidRequest('Validation failed', ['errors' => $errors]);
        }

        $reasonId = (int) $parsed['reason'];
        if (!$this->ratings->reasonExists($reasonId)) {
            return $this->invalidRequest('Unknown rejection reason', ['reason' => $reasonId]);
        }

        try {
            $this->ratings->reject($id, $reasonId);
        } catch (PDOException) {
            return Response::jsonError(
                [
                    'code' => 'INVALID_REQUEST',
                    'message' => 'Could not reject rating',
                    'details' => [],
                ],
                400,
            );
        }

        $this->events->dispatch(RatingEventDispatcher::REJECTED, [
            'ratingId' => $id,
            'reasonId' => $reasonId,
        ]);

        return Response::jsonOk(['id' => $id, 'status' => 'NOT_APPROVED']);
    }

    /** Moderation: delete rating by id. */
    public function delete(Request $request): Response
    {
        $auth = ModerationAuth::requireModerator($request);
        if ($auth !== null) {
            return $auth;
        }

        $id = (int) $request->getAttribute('ratingId', '0');
        if ($id < 1) {
            return $this->invalidRequest('Invalid rating id', ['id' => $id]);
        }

        if ($this->ratings->findById($id) === null) {
            return $this->ratingNotFound($id);
        }

        $deleted = $this->ratings->deleteById($id);
        if (!$deleted) {
            return Response::jsonError(
                [
                    'code' => 'RATING_NOT_FOUND',
                    'message' => 'Rating not found',
                    'details' => ['id' => (string) $id],
                ],
                404,
            );
        }

        $this->events->dispatch(RatingEventDispatcher::DELETED, ['ratingId' => $id]);

        return Response::noContent();
    }

    /** Must be one of the five configured storefront ids. */
    private static function isValidStoreId(string $store): bool
    {
        return StoreCatalog::isKnownStore($store);
    }

    /** Product id path segment: 1–64 safe characters. */
    private static function isValidProductId(string $id): bool
    {
        return preg_match('/^[A-Za-z0-9_-]{1,64}$/', $id) === 1;
    }

    /** Map query source to enum label or null. */
    private static function normalizeSource(mixed $raw): ?string
    {
        if ($raw === null || $raw === '') {
            return null;
        }
        if (!is_string($raw)) {
            return null;
        }
        $u = strtoupper($raw);

        return in_array($u, ['SHOP', 'MAIL', 'INTRANET'], true) ? $u : null;
    }

    /** Format DB datetime for API "created" field. */
    private static function formatDateTime(mixed $dbValue): string
    {
        $t = strtotime((string) $dbValue);

        return $t !== false ? date('Y-m-d H:i:s', $t) : (string) $dbValue;
    }

    /**
     * Parse JSON object body or return 400 Response.
     *
     * @return array<string, mixed>|Response
     */
    private function decodeJsonBody(?string $body): array|Response
    {
        if ($body === null || trim($body) === '') {
            return $this->invalidRequest('JSON body required', []);
        }
        try {
            $data = json_decode($body, true, 512, JSON_THROW_ON_ERROR);
        } catch (\JsonException) {
            return $this->invalidRequest('Invalid JSON', []);
        }
        if (!is_array($data)) {
            return $this->invalidRequest('JSON body must be an object', []);
        }

        return $data;
    }

    /** Standard 404 for missing rating. */
    private function ratingNotFound(int $id): Response
    {
        return Response::jsonError(
            [
                'code' => 'RATING_NOT_FOUND',
                'message' => 'Rating not found',
                'details' => ['id' => (string) $id],
            ],
            404,
        );
    }

    /**
     * Build 400 INVALID_REQUEST envelope.
     *
     * @param array<string, mixed> $details
     */
    private function invalidRequest(string $message, array $details): Response
    {
        return Response::jsonError(
            [
                'code' => 'INVALID_REQUEST',
                'message' => $message,
                'details' => $details,
            ],
            400,
        );
    }
}
