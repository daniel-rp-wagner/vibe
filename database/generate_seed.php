<?php

/**
 * Generates database/seed.sql with reference data and 100 ratings.
 * Run: php database/generate_seed.php
 *
 * Five storefronts: 0001–0005. Approved ratings have explicit rating_visible_stores rows only.
 */

declare(strict_types=1);

$stores = ['0001', '0002', '0003', '0004', '0005'];

$out = fopen(__DIR__ . '/seed.sql', 'wb');
if ($out === false) {
    fwrite(STDERR, "Cannot open seed.sql\n");
    exit(1);
}

fwrite($out, "SET NAMES utf8mb4;\n");
fwrite($out, "SET FOREIGN_KEY_CHECKS = 0;\n");
fwrite($out, "TRUNCATE TABLE rating_criteria_links;\n");
fwrite($out, "TRUNCATE TABLE rating_visible_stores;\n");
fwrite($out, "TRUNCATE TABLE ratings;\n");
fwrite($out, "TRUNCATE TABLE review_criteria;\n");
fwrite($out, "TRUNCATE TABLE rejection_reasons;\n");
fwrite($out, "TRUNCATE TABLE products;\n");
fwrite($out, "SET FOREIGN_KEY_CHECKS = 1;\n\n");

for ($i = 1; $i <= 20; $i++) {
    $id = sprintf('P%03d', $i);
    fwrite($out, "INSERT INTO products (id) VALUES ('{$id}');\n");
}

$reasons = [
    'Vielen Dank für Ihre Bewertung. Diese bezog sich nicht auf das Produkt.',
    'Der Text enthält unzulässige Inhalte.',
    'Die Bewertung ist unvollständig oder unverständlich.',
];
foreach ($reasons as $t) {
    $e = addslashes($t);
    fwrite($out, "INSERT INTO rejection_reasons (message_text) VALUES ('{$e}');\n");
}

$criteria = [
    ['Beschreibung EK-Thema', 'EK', 'einkauf@example.com'],
    ['Beschreibung KS-Thema', 'KS', 'kundenservice@example.com'],
    ['Qualitätsmeldung', 'KS', 'qualitaet@example.com'],
];
foreach ($criteria as [$d, $dep, $em]) {
    fwrite($out, "INSERT INTO review_criteria (description, department, email) VALUES ('"
        . addslashes($d) . "', '{$dep}', '" . addslashes($em) . "');\n");
}

$sources = ['SHOP', 'MAIL', 'INTRANET', 'NULL'];
$statuses = ['APPROVED', 'PENDING', 'NOT_APPROVED'];
$authors = ['Anna B.', 'Max M.', 'Lisa K.', 'Tom R.', 'Sara W.'];

fwrite($out, "\nINSERT INTO ratings (product_id, origin_store, status, star, author, text, email, source, rejection_reason_id) VALUES\n");
$rows = [];
$approvedVisibility = [];
for ($n = 1; $n <= 100; $n++) {
    $pid = sprintf('P%03d', (($n - 1) % 20) + 1);
    $store = $stores[($n - 1) % 5];
    $st = $statuses[$n % 7 === 0 ? 1 : ($n % 13 === 0 ? 2 : 0)];
    $star = ($n % 5) + 1;
    $author = $authors[$n % count($authors)];
    $text = addslashes('Seed-Bewertung #' . $n . ': Produkt wirkt solide.');
    $email = 'user' . $n . '@example.com';
    $srcToken = $sources[$n % 4];
    $srcSql = $srcToken === 'NULL' ? 'NULL' : "'" . $srcToken . "'";
    $reasonSql = 'NULL';
    if ($st === 'NOT_APPROVED') {
        $reasonSql = (string) (($n % 3) + 1);
    }
    $rows[] = "('{$pid}','{$store}','{$st}',{$star},'" . addslashes($author) . "','{$text}','{$email}',{$srcSql},{$reasonSql})";

    if ($st === 'APPROVED') {
        $approvedVisibility[$n] = ($n % 17 === 0) ? ['0001', '0002'] : $stores;
    }
}
fwrite($out, implode(",\n", $rows) . ";\n");

fwrite($out, "\n-- Explicit visibility: one row per store assignment (rating id = row order 1..100)\n");
foreach ($approvedVisibility as $ratingId => $storeList) {
    $vals = [];
    foreach ($storeList as $sid) {
        $vals[] = '(' . $ratingId . ',\'' . $sid . '\')';
    }
    fwrite($out, 'INSERT INTO rating_visible_stores (rating_id, store_id) VALUES ' . implode(',', $vals) . ";\n");
}

fwrite($out, "\nINSERT INTO rating_criteria_links (rating_id, criteria_id) SELECT id, 1 FROM ratings WHERE status = 'APPROVED' AND id % 5 = 0;\n");

fclose($out);
echo "Wrote database/seed.sql\n";
