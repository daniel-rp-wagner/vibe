<?php

declare(strict_types=1);

namespace App\Config;

/**
 * Fixed set of storefronts; visibility is only via rating_visible_stores rows.
 */
final class StoreCatalog
{
    /** @var list<string> */
    public const STORE_IDS = ['0001', '0002', '0003', '0004', '0005'];

    public static function isKnownStore(string $id): bool
    {
        return in_array($id, self::STORE_IDS, true);
    }

    /**
     * @return list<string>
     */
    public static function all(): array
    {
        return self::STORE_IDS;
    }
}
