<?php

declare(strict_types=1);

namespace App\Validation;

/**
 * Validates decoded JSON (associative arrays) against project JSON Schema files.
 * Covers the subset used by schemas in /schemas (types, object, array, string, integer, const, pattern, format email, uniqueItems, minItems).
 */
final class SchemaValidator
{
    public function __construct(
        private readonly string $schemaBaseDir,
    ) {
    }

    /**
     * @return list<string> Empty if valid
     */
    /**
     * Validate $data against a file in schemaBaseDir; returns human-readable errors.
     *
     * @return list<string>
     */
    public function validate(mixed $data, string $schemaFileName): array
    {
        $path = $this->schemaBaseDir . DIRECTORY_SEPARATOR . $schemaFileName;
        if (!is_readable($path)) {
            return ['Schema file not readable: ' . $schemaFileName];
        }
        $raw = file_get_contents($path);
        if ($raw === false) {
            return ['Schema file read failed'];
        }
        try {
            $schema = json_decode($raw, true, 512, JSON_THROW_ON_ERROR);
        } catch (\JsonException $e) {
            return ['Invalid schema JSON: ' . $e->getMessage()];
        }
        if (!is_array($schema)) {
            return ['Schema root must be an object'];
        }

        return $this->validateNode($data, $schema, '$');
    }

    /**
     * Recursive validation for a schema node.
     *
     * @param array<string, mixed> $schema
     * @return list<string>
     */
    private function validateNode(mixed $instance, array $schema, string $path): array
    {
        if (array_key_exists('const', $schema)) {
            $expected = $schema['const'];

            return $instance === $expected ? [] : [$path . ': must match const'];
        }

        $type = $schema['type'] ?? null;
        if ($type === null) {
            return [];
        }

        return match ($type) {
            'object' => $this->validateObject($instance, $schema, $path),
            'array' => $this->validateArray($instance, $schema, $path),
            'string' => $this->validateString($instance, $schema, $path),
            'integer' => $this->validateInteger($instance, $schema, $path),
            default => [$path . ': unsupported schema type'],
        };
    }

    /**
     * Validate JSON object instance (PHP associative array, not list).
     *
     * @param array<string, mixed> $schema
     * @return list<string>
     */
    private function validateObject(mixed $instance, array $schema, string $path): array
    {
        if (!is_array($instance) || array_is_list($instance)) {
            return [$path . ': must be object'];
        }
        /** @var array<string, mixed> $obj */
        $obj = $instance;
        $errors = [];
        foreach ($schema['required'] ?? [] as $req) {
            if (!is_string($req)) {
                continue;
            }
            if (!array_key_exists($req, $obj)) {
                $errors[] = $path . ': missing required property ' . $req;
            }
        }
        $props = $schema['properties'] ?? [];
        $additional = $schema['additionalProperties'] ?? true;
        foreach ($obj as $key => $value) {
            if (!is_string($key)) {
                continue;
            }
            if (isset($props[$key]) && is_array($props[$key])) {
                $errors = array_merge($errors, $this->validateNode($value, $props[$key], $path . '.' . $key));
            } elseif ($additional === false) {
                $errors[] = $path . ': additional property not allowed: ' . $key;
            }
        }

        return $errors;
    }

    /**
     * Validate JSON array (PHP list).
     *
     * @param array<string, mixed> $schema
     * @return list<string>
     */
    private function validateArray(mixed $instance, array $schema, string $path): array
    {
        if (!is_array($instance) || !array_is_list($instance)) {
            return [$path . ': must be array'];
        }
        $errors = [];
        $items = $schema['items'] ?? null;
        if (is_array($items)) {
            foreach ($instance as $i => $el) {
                $errors = array_merge($errors, $this->validateNode($el, $items, $path . '[' . $i . ']'));
            }
        }
        if (isset($schema['minItems'])) {
            $min = (int) $schema['minItems'];
            if (count($instance) < $min) {
                $errors[] = $path . ': must have at least ' . $min . ' items';
            }
        }
        if (!empty($schema['uniqueItems'])) {
            $seen = [];
            foreach ($instance as $i => $el) {
                $key = json_encode($el, JSON_THROW_ON_ERROR);
                if (isset($seen[$key])) {
                    $errors[] = $path . ': items must be unique';
                    break;
                }
                $seen[$key] = true;
            }
        }

        return $errors;
    }

    /**
     * @param array<string, mixed> $schema
     * @return list<string>
     */
    private function validateString(mixed $instance, array $schema, string $path): array
    {
        if (!is_string($instance)) {
            return [$path . ': must be string'];
        }
        $errors = [];
        if (isset($schema['minLength']) && strlen($instance) < (int) $schema['minLength']) {
            $errors[] = $path . ': string too short';
        }
        if (isset($schema['maxLength']) && strlen($instance) > (int) $schema['maxLength']) {
            $errors[] = $path . ': string too long';
        }
        if (isset($schema['pattern'])) {
            $p = (string) $schema['pattern'];
            $delim = '#';
            $escaped = str_replace($delim, '\\' . $delim, $p);
            if (preg_match($delim . $escaped . $delim . 'u', $instance) !== 1) {
                $errors[] = $path . ': does not match pattern';
            }
        }
        if (($schema['format'] ?? null) === 'email') {
            if (filter_var($instance, FILTER_VALIDATE_EMAIL) === false) {
                $errors[] = $path . ': invalid email';
            }
        }

        return $errors;
    }

    /**
     * Strict integer (JSON numbers decoded as int in PHP).
     *
     * @param array<string, mixed> $schema
     * @return list<string>
     */
    private function validateInteger(mixed $instance, array $schema, string $path): array
    {
        if (!is_int($instance)) {
            return [$path . ': must be integer'];
        }
        $errors = [];
        if (isset($schema['minimum']) && $instance < (int) $schema['minimum']) {
            $errors[] = $path . ': below minimum';
        }
        if (isset($schema['maximum']) && $instance > (int) $schema['maximum']) {
            $errors[] = $path . ': above maximum';
        }

        return $errors;
    }
}
