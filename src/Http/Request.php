<?php

declare(strict_types=1);

namespace App\Http;

/**
 * Immutable HTTP request wrapper.
 *
 * Query, body, and normalized headers are exposed via getters below.
 */
final class Request
{
    /**
     * @param array<string, string> $query
     * @param array<string, mixed> $attributes Route placeholders
     */
    public function __construct(
        private readonly string $method,
        private readonly string $path,
        private readonly array $query,
        private readonly ?string $body,
        private readonly array $attributes = [],
        private readonly array $headers = [],
    ) {
    }

    /**
     * Build request from PHP superglobals and php://input.
     */
    public static function fromGlobals(): self
    {
        $uri = $_SERVER['REQUEST_URI'] ?? '/';
        $path = parse_url($uri, PHP_URL_PATH);
        if (!is_string($path) || $path === '') {
            $path = '/';
        }
        $headers = [];
        if (function_exists('getallheaders')) {
            $raw = getallheaders();
            if (is_array($raw)) {
                foreach ($raw as $k => $v) {
                    $headers[strtolower((string) $k)] = (string) $v;
                }
            }
        }

        $body = file_get_contents('php://input');
        if ($body === false) {
            $body = '';
        }

        return new self(
            strtoupper($_SERVER['REQUEST_METHOD'] ?? 'GET'),
            $path,
            $_GET,
            $body !== '' ? $body : null,
            [],
            $headers,
        );
    }

    /**
     * Clone with route placeholder values from regex matches.
     *
     * @param array<string, string> $attributes
     */
    public function withAttributes(array $attributes): self
    {
        return new self(
            $this->method,
            $this->path,
            $this->query,
            $this->body,
            $attributes,
            $this->headers,
        );
    }

    public function getMethod(): string
    {
        return $this->method;
    }

    public function getPath(): string
    {
        return $this->path;
    }

    /** @return array<string, string> */
    public function getQuery(): array
    {
        return $this->query;
    }

    public function getBody(): ?string
    {
        return $this->body;
    }

    /** @return array<string, mixed> */
    public function getAttributes(): array
    {
        return $this->attributes;
    }

    public function getAttribute(string $key, mixed $default = null): mixed
    {
        return $this->attributes[$key] ?? $default;
    }

    public function getHeader(string $name): ?string
    {
        return $this->headers[strtolower($name)] ?? null;
    }
}
