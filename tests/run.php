<?php

/**
 * Lightweight checks without PHPUnit (Composer/ZIP optional).
 * Run: php tests/run.php
 */

declare(strict_types=1);

require dirname(__DIR__) . '/src/autoload.php';

use App\Validation\SchemaValidator;

$schemas = dirname(__DIR__) . DIRECTORY_SEPARATOR . 'schemas';
$v = new SchemaValidator($schemas);

$ok = $v->validate(
    ['rating' => 5, 'author' => 'A', 'text' => 'T', 'email' => 'a@b.co'],
    'post-rating.schema.json',
);
assert($ok === [], 'valid post-rating should pass');

$bad = $v->validate(
    ['rating' => 6, 'author' => 'A', 'text' => 'T', 'email' => 'a@b.co'],
    'post-rating.schema.json',
);
assert($bad !== [], 'invalid star should fail');

$ap = $v->validate(
    ['status' => 'APPROVED', 'criteria' => [1, 2], 'store_ids' => ['0001']],
    'post-approve.schema.json',
);
assert($ap === [], 'valid approve should pass');

$rj = $v->validate(
    ['status' => 'NOT_APPROVED', 'reason' => 1],
    'post-reject.schema.json',
);
assert($rj === [], 'valid reject should pass');

echo "tests/run.php: OK\n";
