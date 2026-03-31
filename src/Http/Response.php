<?php

declare(strict_types=1);

namespace App\Http;

/**
 * JSON-first HTTP response.
 */
final class Response
{
    /**
     * @param array<string, mixed>|null $data
     * @param array<string, mixed>|null $error
     */
    public function __construct(
        private readonly ?array $data,
        private readonly ?array $error,
        private readonly int $statusCode,
    ) {
    }

    /**
     * Success envelope with JSON body and optional non-200 success (e.g. 201).
     */
    public static function jsonOk(array $data, int $code = 200): self
    {
        return new self($data, null, $code);
    }

    /**
     * @param array<string, mixed> $errorPayload Must include code, message; optional details
     */
    /**
     * Error envelope; $errorPayload must include code and message.
     *
     * @param array<string, mixed> $errorPayload
     */
    public static function jsonError(array $errorPayload, int $statusCode): self
    {
        return new self(null, $errorPayload, $statusCode);
    }

    /** HTTP 204 with empty body. */
    public static function noContent(): self
    {
        return new self(null, null, 204);
    }

    /** Emit status, Content-Type, and JSON envelope (unless 204). */
    public function send(): void
    {
        http_response_code($this->statusCode);
        header('Content-Type: application/json; charset=utf-8');
        if ($this->statusCode === 204) {
            return;
        }
        $envelope = [
            'data' => $this->data,
            'error' => $this->error,
        ];
        echo json_encode($envelope, JSON_THROW_ON_ERROR | JSON_UNESCAPED_UNICODE);
    }
}
