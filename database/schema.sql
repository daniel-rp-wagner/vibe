-- Ratings API — MySQL schema (UTF-8)
-- Extended model: product catalog stub, rejection reasons, review criteria, per-shop visibility.

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS rating_criteria_links;
DROP TABLE IF EXISTS rating_visible_stores;
DROP TABLE IF EXISTS ratings;
DROP TABLE IF EXISTS review_criteria;
DROP TABLE IF EXISTS rejection_reasons;
DROP TABLE IF EXISTS products;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE products (
    id VARCHAR(64) NOT NULL,
    created_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE rejection_reasons (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    message_text VARCHAR(2000) NOT NULL,
    created_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE review_criteria (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    description VARCHAR(500) NOT NULL,
    department ENUM('EK', 'KS') NOT NULL,
    email VARCHAR(255) NOT NULL,
    created_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    KEY idx_review_criteria_department (department)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE ratings (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    product_id VARCHAR(64) NOT NULL,
    origin_store CHAR(4) NOT NULL COMMENT 'Four-digit numeric store id, leading zeros allowed',
    status ENUM('PENDING', 'APPROVED', 'NOT_APPROVED') NOT NULL DEFAULT 'PENDING',
    star TINYINT UNSIGNED NOT NULL,
    author VARCHAR(255) NOT NULL,
    text VARCHAR(1000) NOT NULL,
    email VARCHAR(255) NOT NULL,
    source ENUM('SHOP', 'MAIL', 'INTRANET') NULL DEFAULT NULL,
    rejection_reason_id INT UNSIGNED NULL,
    visible_all_stores TINYINT(1) NOT NULL DEFAULT 1 COMMENT '1 = all shops; 0 = only rows in rating_visible_stores',
    created_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    CONSTRAINT chk_star CHECK (star BETWEEN 1 AND 5),
    CONSTRAINT fk_ratings_product FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_ratings_reason FOREIGN KEY (rejection_reason_id) REFERENCES rejection_reasons (id) ON DELETE SET NULL ON UPDATE CASCADE,
    KEY idx_ratings_public_list (product_id, status, created_at),
    KEY idx_ratings_origin (origin_store),
    KEY idx_ratings_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE rating_visible_stores (
    rating_id BIGINT UNSIGNED NOT NULL,
    store_id CHAR(4) NOT NULL,
    created_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (rating_id, store_id),
    KEY idx_visible_store (store_id, rating_id),
    CONSTRAINT fk_rvs_rating FOREIGN KEY (rating_id) REFERENCES ratings (id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE rating_criteria_links (
    rating_id BIGINT UNSIGNED NOT NULL,
    criteria_id INT UNSIGNED NOT NULL,
    created_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    PRIMARY KEY (rating_id, criteria_id),
    CONSTRAINT fk_rcl_rating FOREIGN KEY (rating_id) REFERENCES ratings (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_rcl_criteria FOREIGN KEY (criteria_id) REFERENCES review_criteria (id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
