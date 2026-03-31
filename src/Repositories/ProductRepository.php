<?php

declare(strict_types=1);

namespace App\Repositories;

use PDO;

/**
 * Stub product registry for PRODUCT_NOT_FOUND semantics.
 */
final class ProductRepository
{
    public function __construct(
        private readonly PDO $pdo,
    ) {
    }

    /** Return whether the product id exists in the local registry. */
    public function exists(string $productId): bool
    {
        $stmt = $this->pdo->prepare('SELECT 1 FROM products WHERE id = ? LIMIT 1');
        $stmt->execute([$productId]);

        return (bool) $stmt->fetchColumn();
    }
}
