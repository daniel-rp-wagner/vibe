<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Http\Request;
use App\Http\Response;
use PDO;

/**
 * Liveness and readiness probes.
 */
final class HealthController
{
    public function __construct(
        private readonly PDO $pdo,
    ) {
    }

    /** Liveness probe without dependency checks. */
    public function health(Request $request): Response
    {
        return Response::jsonOk(['status' => 'ok']);
    }

    /** Readiness probe: simple DB round-trip. */
    public function ready(Request $request): Response
    {
        try {
            $this->pdo->query('SELECT 1');
        } catch (\Throwable) {
            return Response::jsonError(
                [
                    'code' => 'INVALID_REQUEST',
                    'message' => 'Database not ready',
                    'details' => [],
                ],
                503,
            );
        }

        return Response::jsonOk(['status' => 'ready']);
    }
}
