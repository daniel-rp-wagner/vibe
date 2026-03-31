<?php

declare(strict_types=1);

namespace App\Events;

/**
 * Minimal domain events: structured log line to PHP error_log (transport TBD).
 */
final class RatingEventDispatcher
{
    public const CREATED = 'rating.created';

    public const APPROVED = 'rating.approved';

    public const REJECTED = 'rating.rejected';

    public const DELETED = 'rating.deleted';

    /**
     * @param array<string, mixed> $payload
     */
    /**
     * Append one JSON line to the PHP error log for downstream integrations.
     *
     * @param array<string, mixed> $payload
     */
    public function dispatch(string $type, array $payload): void
    {
        $line = json_encode(
            [
                'event' => $type,
                'time' => gmdate('c'),
                'payload' => $payload,
            ],
            JSON_THROW_ON_ERROR | JSON_UNESCAPED_UNICODE,
        );
        error_log($line);
    }
}
