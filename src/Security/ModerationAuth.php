<?php

declare(strict_types=1);

namespace App\Security;

use App\Config\Env;
use App\Http\Request;
use App\Http\Response;

/**
 * Shared-secret moderation auth via Authorization: Bearer <key> or X-API-Key.
 */
final class ModerationAuth
{
    /**
     * Ensure moderation secret is present; return 401/500 Response or null if OK.
     */
    public static function requireModerator(Request $request): ?Response
    {
        $expected = Env::get('MODERATION_API_KEY');
        if ($expected === null || $expected === '') {
            return Response::jsonError(
                [
                    'code' => 'INTERNAL_ERROR',
                    'message' => 'Moderation is not configured',
                    'details' => [],
                ],
                500,
            );
        }

        $token = self::extractToken($request);
        if ($token === null || !hash_equals($expected, $token)) {
            return Response::jsonError(
                [
                    'code' => 'UNAUTHORIZED',
                    'message' => 'Unauthorized',
                    'details' => [],
                ],
                401,
            );
        }

        return null;
    }

    /** Read secret from X-API-Key or Authorization Bearer. */
    private static function extractToken(Request $request): ?string
    {
        $apiKey = $request->getHeader('x-api-key');
        if ($apiKey !== null && $apiKey !== '') {
            return $apiKey;
        }
        $auth = $request->getHeader('authorization');
        if ($auth === null || !preg_match('/^\s*Bearer\s+(.+)$/i', $auth, $m)) {
            return null;
        }

        return trim($m[1]);
    }
}
