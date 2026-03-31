<?php

declare(strict_types=1);

namespace App\Repositories;

use App\Config\StoreCatalog;
use PDO;
use PDOException;

/**
 * Persistence for ratings, visibility, criteria links, and aggregations.
 */
final class RatingRepository
{
    public function __construct(
        private readonly PDO $pdo,
    ) {
    }

    /** Load one rating row by primary key or null. */
    public function findById(int $id): ?array
    {
        $stmt = $this->pdo->prepare('SELECT * FROM ratings WHERE id = ? LIMIT 1');
        $stmt->execute([$id]);
        $row = $stmt->fetch(PDO::FETCH_ASSOC);

        return $row === false ? null : $row;
    }

    /**
     * Approved ratings visible in $storeId, newest first.
     *
     * @return list<array<string, mixed>>
     */
    public function listApprovedForStoreAndProduct(string $storeId, string $productId): array
    {
        $sql = <<<'SQL'
            SELECT r.id, r.star, r.text, r.author, r.created_at
            FROM ratings r
            WHERE r.product_id = ?
              AND r.status = 'APPROVED'
              AND EXISTS (
                  SELECT 1 FROM rating_visible_stores v
                  WHERE v.rating_id = r.id AND v.store_id = ?
              )
            ORDER BY r.created_at DESC
            SQL;
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute([$productId, $storeId]);

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    /**
     * Live star histogram for approved ratings visible in the store.
     *
     * @return array{1:int,2:int,3:int,4:int,5:int}
     */
    public function distributionForStoreAndProduct(string $storeId, string $productId): array
    {
        $base = [1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0];
        $sql = <<<'SQL'
            SELECT r.star AS star, COUNT(*) AS c
            FROM ratings r
            WHERE r.product_id = ?
              AND r.status = 'APPROVED'
              AND EXISTS (
                  SELECT 1 FROM rating_visible_stores v
                  WHERE v.rating_id = r.id AND v.store_id = ?
              )
            GROUP BY r.star
            SQL;
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute([$productId, $storeId]);
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $s = (int) $row['star'];
            if ($s >= 1 && $s <= 5) {
                $base[$s] = (int) $row['c'];
            }
        }

        return $base;
    }

    /** Average star (one decimal) or null if no approved ratings. */
    public function averageStarsForStoreAndProduct(string $storeId, string $productId): ?float
    {
        $sql = <<<'SQL'
            SELECT AVG(r.star) AS avg_star, COUNT(*) AS cnt
            FROM ratings r
            WHERE r.product_id = ?
              AND r.status = 'APPROVED'
              AND EXISTS (
                  SELECT 1 FROM rating_visible_stores v
                  WHERE v.rating_id = r.id AND v.store_id = ?
              )
            SQL;
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute([$productId, $storeId]);
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($row === false || (int) $row['cnt'] === 0) {
            return null;
        }

        return round((float) $row['avg_star'], 1);
    }

    /**
     * Insert a new PENDING rating.
     *
     * @param 'SHOP'|'MAIL'|'INTRANET'|null $source
     */
    public function insertPending(
        string $productId,
        string $originStore,
        int $star,
        string $author,
        string $text,
        string $email,
        ?string $source,
    ): int {
        $stmt = $this->pdo->prepare(
            'INSERT INTO ratings (product_id, origin_store, status, star, author, text, email, source, rejection_reason_id)
             VALUES (?, ?, \'PENDING\', ?, ?, ?, ?, ?, NULL)',
        );
        $stmt->execute([$productId, $originStore, $star, $author, $text, $email, $source]);

        return (int) $this->pdo->lastInsertId();
    }

    /** Hard-delete rating (cascades child rows). */
    public function deleteById(int $id): bool
    {
        $stmt = $this->pdo->prepare('DELETE FROM ratings WHERE id = ?');

        return $stmt->execute([$id]) && $stmt->rowCount() > 0;
    }

    /**
     * Set APPROVED, explicit visibility rows (subset of StoreCatalog), optional criteria links.
     *
     * @param list<int> $criteriaIds
     * @param list<string>|null $storeIds Known store ids; null = all five stores
     */
    public function approve(int $ratingId, array $criteriaIds, ?array $storeIds): void
    {
        $targets = $storeIds === null ? StoreCatalog::all() : array_values(array_unique($storeIds));
        if ($targets === []) {
            throw new \InvalidArgumentException('store_ids must not be empty when provided');
        }
        foreach ($targets as $sid) {
            if (!StoreCatalog::isKnownStore($sid)) {
                throw new \InvalidArgumentException('Unknown store id: ' . $sid);
            }
        }

        $this->pdo->beginTransaction();
        try {
            $stmt = $this->pdo->prepare(
                'UPDATE ratings SET status = \'APPROVED\', rejection_reason_id = NULL, updated_at = CURRENT_TIMESTAMP(6) WHERE id = ?',
            );
            $stmt->execute([$ratingId]);

            $this->pdo->prepare('DELETE FROM rating_visible_stores WHERE rating_id = ?')->execute([$ratingId]);
            $ins = $this->pdo->prepare(
                'INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (?, ?)',
            );
            foreach ($targets as $sid) {
                $ins->execute([$ratingId, $sid]);
            }

            $this->pdo->prepare('DELETE FROM rating_criteria_links WHERE rating_id = ?')->execute([$ratingId]);
            if ($criteriaIds !== []) {
                $link = $this->pdo->prepare(
                    'INSERT INTO rating_criteria_links (rating_id, criteria_id) VALUES (?, ?)',
                );
                foreach ($criteriaIds as $cid) {
                    $link->execute([$ratingId, $cid]);
                }
            }
            $this->pdo->commit();
        } catch (PDOException $e) {
            $this->pdo->rollBack();
            throw $e;
        }
    }

    /** Set NOT_APPROVED with reason; clear visibility and criteria links. */
    public function reject(int $ratingId, int $reasonId): void
    {
        $this->pdo->beginTransaction();
        try {
            $stmt = $this->pdo->prepare(
                'UPDATE ratings SET status = \'NOT_APPROVED\', rejection_reason_id = ?, updated_at = CURRENT_TIMESTAMP(6) WHERE id = ?',
            );
            $stmt->execute([$reasonId, $ratingId]);
            $this->pdo->prepare('DELETE FROM rating_visible_stores WHERE rating_id = ?')->execute([$ratingId]);
            $this->pdo->prepare('DELETE FROM rating_criteria_links WHERE rating_id = ?')->execute([$ratingId]);
            $this->pdo->commit();
        } catch (PDOException $e) {
            $this->pdo->rollBack();
            throw $e;
        }
    }

    /** True if rejection_reasons row exists. */
    public function reasonExists(int $id): bool
    {
        $stmt = $this->pdo->prepare('SELECT 1 FROM rejection_reasons WHERE id = ? LIMIT 1');
        $stmt->execute([$id]);

        return (bool) $stmt->fetchColumn();
    }

    /**
     * True if every criteria id exists (empty list is valid).
     *
     * @param list<int> $ids
     */
    public function criteriaExist(array $ids): bool
    {
        if ($ids === []) {
            return true;
        }
        $placeholders = implode(',', array_fill(0, count($ids), '?'));
        $stmt = $this->pdo->prepare("SELECT COUNT(DISTINCT id) FROM review_criteria WHERE id IN ($placeholders)");
        $stmt->execute($ids);

        return (int) $stmt->fetchColumn() === count($ids);
    }
}
