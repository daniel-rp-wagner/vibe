<?php

declare(strict_types=1);

namespace App\Config;

/**
 * Loads key/value pairs from a .env file (KEY=value, no export syntax).
 */
final class Env
{
    /** @var array<string, string> */
    private static array $vars = [];

    /**
     * Load variables from a .env file into static storage.
     */
    public static function load(string $path): void
    {
        if (!is_readable($path)) {
            return;
        }
        $lines = file($path, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
        if ($lines === false) {
            return;
        }
        foreach ($lines as $line) {
            $line = trim($line);
            if ($line === '' || str_starts_with($line, '#')) {
                continue;
            }
            if (!str_contains($line, '=')) {
                continue;
            }
            [$name, $value] = explode('=', $line, 2);
            $name = trim($name);
            $value = trim($value);
            if ($name !== '') {
                self::$vars[$name] = $value;
            }
        }
    }

    /**
     * Read env var from loaded .env, then $_ENV / $_SERVER.
     */
    public static function get(string $key, ?string $default = null): ?string
    {
        return self::$vars[$key] ?? $_ENV[$key] ?? $_SERVER[$key] ?? $default;
    }
}
