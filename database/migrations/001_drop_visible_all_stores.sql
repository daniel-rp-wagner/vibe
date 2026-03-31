-- Run once on existing databases that still have visible_all_stores.
ALTER TABLE ratings DROP COLUMN visible_all_stores;
