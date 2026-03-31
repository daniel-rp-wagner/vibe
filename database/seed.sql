SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE rating_criteria_links;
TRUNCATE TABLE rating_visible_stores;
TRUNCATE TABLE ratings;
TRUNCATE TABLE review_criteria;
TRUNCATE TABLE rejection_reasons;
TRUNCATE TABLE products;
SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO products (id) VALUES ('P001');
INSERT INTO products (id) VALUES ('P002');
INSERT INTO products (id) VALUES ('P003');
INSERT INTO products (id) VALUES ('P004');
INSERT INTO products (id) VALUES ('P005');
INSERT INTO products (id) VALUES ('P006');
INSERT INTO products (id) VALUES ('P007');
INSERT INTO products (id) VALUES ('P008');
INSERT INTO products (id) VALUES ('P009');
INSERT INTO products (id) VALUES ('P010');
INSERT INTO products (id) VALUES ('P011');
INSERT INTO products (id) VALUES ('P012');
INSERT INTO products (id) VALUES ('P013');
INSERT INTO products (id) VALUES ('P014');
INSERT INTO products (id) VALUES ('P015');
INSERT INTO products (id) VALUES ('P016');
INSERT INTO products (id) VALUES ('P017');
INSERT INTO products (id) VALUES ('P018');
INSERT INTO products (id) VALUES ('P019');
INSERT INTO products (id) VALUES ('P020');
INSERT INTO rejection_reasons (message_text) VALUES ('Vielen Dank für Ihre Bewertung. Diese bezog sich nicht auf das Produkt.');
INSERT INTO rejection_reasons (message_text) VALUES ('Der Text enthält unzulässige Inhalte.');
INSERT INTO rejection_reasons (message_text) VALUES ('Die Bewertung ist unvollständig oder unverständlich.');
INSERT INTO review_criteria (description, department, email) VALUES ('Beschreibung EK-Thema', 'EK', 'einkauf@example.com');
INSERT INTO review_criteria (description, department, email) VALUES ('Beschreibung KS-Thema', 'KS', 'kundenservice@example.com');
INSERT INTO review_criteria (description, department, email) VALUES ('Qualitätsmeldung', 'KS', 'qualitaet@example.com');

INSERT INTO ratings (product_id, origin_store, status, star, author, text, email, source, rejection_reason_id) VALUES
('P001','0001','APPROVED',2,'Max M.','Seed-Bewertung #1: Produkt wirkt solide.','user1@example.com','MAIL',NULL),
('P002','0002','APPROVED',3,'Lisa K.','Seed-Bewertung #2: Produkt wirkt solide.','user2@example.com','INTRANET',NULL),
('P003','0003','APPROVED',4,'Tom R.','Seed-Bewertung #3: Produkt wirkt solide.','user3@example.com',NULL,NULL),
('P004','0004','APPROVED',5,'Sara W.','Seed-Bewertung #4: Produkt wirkt solide.','user4@example.com','SHOP',NULL),
('P005','0005','APPROVED',1,'Anna B.','Seed-Bewertung #5: Produkt wirkt solide.','user5@example.com','MAIL',NULL),
('P006','0001','APPROVED',2,'Max M.','Seed-Bewertung #6: Produkt wirkt solide.','user6@example.com','INTRANET',NULL),
('P007','0002','PENDING',3,'Lisa K.','Seed-Bewertung #7: Produkt wirkt solide.','user7@example.com',NULL,NULL),
('P008','0003','APPROVED',4,'Tom R.','Seed-Bewertung #8: Produkt wirkt solide.','user8@example.com','SHOP',NULL),
('P009','0004','APPROVED',5,'Sara W.','Seed-Bewertung #9: Produkt wirkt solide.','user9@example.com','MAIL',NULL),
('P010','0005','APPROVED',1,'Anna B.','Seed-Bewertung #10: Produkt wirkt solide.','user10@example.com','INTRANET',NULL),
('P011','0001','APPROVED',2,'Max M.','Seed-Bewertung #11: Produkt wirkt solide.','user11@example.com',NULL,NULL),
('P012','0002','APPROVED',3,'Lisa K.','Seed-Bewertung #12: Produkt wirkt solide.','user12@example.com','SHOP',NULL),
('P013','0003','NOT_APPROVED',4,'Tom R.','Seed-Bewertung #13: Produkt wirkt solide.','user13@example.com','MAIL',2),
('P014','0004','PENDING',5,'Sara W.','Seed-Bewertung #14: Produkt wirkt solide.','user14@example.com','INTRANET',NULL),
('P015','0005','APPROVED',1,'Anna B.','Seed-Bewertung #15: Produkt wirkt solide.','user15@example.com',NULL,NULL),
('P016','0001','APPROVED',2,'Max M.','Seed-Bewertung #16: Produkt wirkt solide.','user16@example.com','SHOP',NULL),
('P017','0002','APPROVED',3,'Lisa K.','Seed-Bewertung #17: Produkt wirkt solide.','user17@example.com','MAIL',NULL),
('P018','0003','APPROVED',4,'Tom R.','Seed-Bewertung #18: Produkt wirkt solide.','user18@example.com','INTRANET',NULL),
('P019','0004','APPROVED',5,'Sara W.','Seed-Bewertung #19: Produkt wirkt solide.','user19@example.com',NULL,NULL),
('P020','0005','APPROVED',1,'Anna B.','Seed-Bewertung #20: Produkt wirkt solide.','user20@example.com','SHOP',NULL),
('P001','0001','PENDING',2,'Max M.','Seed-Bewertung #21: Produkt wirkt solide.','user21@example.com','MAIL',NULL),
('P002','0002','APPROVED',3,'Lisa K.','Seed-Bewertung #22: Produkt wirkt solide.','user22@example.com','INTRANET',NULL),
('P003','0003','APPROVED',4,'Tom R.','Seed-Bewertung #23: Produkt wirkt solide.','user23@example.com',NULL,NULL),
('P004','0004','APPROVED',5,'Sara W.','Seed-Bewertung #24: Produkt wirkt solide.','user24@example.com','SHOP',NULL),
('P005','0005','APPROVED',1,'Anna B.','Seed-Bewertung #25: Produkt wirkt solide.','user25@example.com','MAIL',NULL),
('P006','0001','NOT_APPROVED',2,'Max M.','Seed-Bewertung #26: Produkt wirkt solide.','user26@example.com','INTRANET',3),
('P007','0002','APPROVED',3,'Lisa K.','Seed-Bewertung #27: Produkt wirkt solide.','user27@example.com',NULL,NULL),
('P008','0003','PENDING',4,'Tom R.','Seed-Bewertung #28: Produkt wirkt solide.','user28@example.com','SHOP',NULL),
('P009','0004','APPROVED',5,'Sara W.','Seed-Bewertung #29: Produkt wirkt solide.','user29@example.com','MAIL',NULL),
('P010','0005','APPROVED',1,'Anna B.','Seed-Bewertung #30: Produkt wirkt solide.','user30@example.com','INTRANET',NULL),
('P011','0001','APPROVED',2,'Max M.','Seed-Bewertung #31: Produkt wirkt solide.','user31@example.com',NULL,NULL),
('P012','0002','APPROVED',3,'Lisa K.','Seed-Bewertung #32: Produkt wirkt solide.','user32@example.com','SHOP',NULL),
('P013','0003','APPROVED',4,'Tom R.','Seed-Bewertung #33: Produkt wirkt solide.','user33@example.com','MAIL',NULL),
('P014','0004','APPROVED',5,'Sara W.','Seed-Bewertung #34: Produkt wirkt solide.','user34@example.com','INTRANET',NULL),
('P015','0005','PENDING',1,'Anna B.','Seed-Bewertung #35: Produkt wirkt solide.','user35@example.com',NULL,NULL),
('P016','0001','APPROVED',2,'Max M.','Seed-Bewertung #36: Produkt wirkt solide.','user36@example.com','SHOP',NULL),
('P017','0002','APPROVED',3,'Lisa K.','Seed-Bewertung #37: Produkt wirkt solide.','user37@example.com','MAIL',NULL),
('P018','0003','APPROVED',4,'Tom R.','Seed-Bewertung #38: Produkt wirkt solide.','user38@example.com','INTRANET',NULL),
('P019','0004','NOT_APPROVED',5,'Sara W.','Seed-Bewertung #39: Produkt wirkt solide.','user39@example.com',NULL,1),
('P020','0005','APPROVED',1,'Anna B.','Seed-Bewertung #40: Produkt wirkt solide.','user40@example.com','SHOP',NULL),
('P001','0001','APPROVED',2,'Max M.','Seed-Bewertung #41: Produkt wirkt solide.','user41@example.com','MAIL',NULL),
('P002','0002','PENDING',3,'Lisa K.','Seed-Bewertung #42: Produkt wirkt solide.','user42@example.com','INTRANET',NULL),
('P003','0003','APPROVED',4,'Tom R.','Seed-Bewertung #43: Produkt wirkt solide.','user43@example.com',NULL,NULL),
('P004','0004','APPROVED',5,'Sara W.','Seed-Bewertung #44: Produkt wirkt solide.','user44@example.com','SHOP',NULL),
('P005','0005','APPROVED',1,'Anna B.','Seed-Bewertung #45: Produkt wirkt solide.','user45@example.com','MAIL',NULL),
('P006','0001','APPROVED',2,'Max M.','Seed-Bewertung #46: Produkt wirkt solide.','user46@example.com','INTRANET',NULL),
('P007','0002','APPROVED',3,'Lisa K.','Seed-Bewertung #47: Produkt wirkt solide.','user47@example.com',NULL,NULL),
('P008','0003','APPROVED',4,'Tom R.','Seed-Bewertung #48: Produkt wirkt solide.','user48@example.com','SHOP',NULL),
('P009','0004','PENDING',5,'Sara W.','Seed-Bewertung #49: Produkt wirkt solide.','user49@example.com','MAIL',NULL),
('P010','0005','APPROVED',1,'Anna B.','Seed-Bewertung #50: Produkt wirkt solide.','user50@example.com','INTRANET',NULL),
('P011','0001','APPROVED',2,'Max M.','Seed-Bewertung #51: Produkt wirkt solide.','user51@example.com',NULL,NULL),
('P012','0002','NOT_APPROVED',3,'Lisa K.','Seed-Bewertung #52: Produkt wirkt solide.','user52@example.com','SHOP',2),
('P013','0003','APPROVED',4,'Tom R.','Seed-Bewertung #53: Produkt wirkt solide.','user53@example.com','MAIL',NULL),
('P014','0004','APPROVED',5,'Sara W.','Seed-Bewertung #54: Produkt wirkt solide.','user54@example.com','INTRANET',NULL),
('P015','0005','APPROVED',1,'Anna B.','Seed-Bewertung #55: Produkt wirkt solide.','user55@example.com',NULL,NULL),
('P016','0001','PENDING',2,'Max M.','Seed-Bewertung #56: Produkt wirkt solide.','user56@example.com','SHOP',NULL),
('P017','0002','APPROVED',3,'Lisa K.','Seed-Bewertung #57: Produkt wirkt solide.','user57@example.com','MAIL',NULL),
('P018','0003','APPROVED',4,'Tom R.','Seed-Bewertung #58: Produkt wirkt solide.','user58@example.com','INTRANET',NULL),
('P019','0004','APPROVED',5,'Sara W.','Seed-Bewertung #59: Produkt wirkt solide.','user59@example.com',NULL,NULL),
('P020','0005','APPROVED',1,'Anna B.','Seed-Bewertung #60: Produkt wirkt solide.','user60@example.com','SHOP',NULL),
('P001','0001','APPROVED',2,'Max M.','Seed-Bewertung #61: Produkt wirkt solide.','user61@example.com','MAIL',NULL),
('P002','0002','APPROVED',3,'Lisa K.','Seed-Bewertung #62: Produkt wirkt solide.','user62@example.com','INTRANET',NULL),
('P003','0003','PENDING',4,'Tom R.','Seed-Bewertung #63: Produkt wirkt solide.','user63@example.com',NULL,NULL),
('P004','0004','APPROVED',5,'Sara W.','Seed-Bewertung #64: Produkt wirkt solide.','user64@example.com','SHOP',NULL),
('P005','0005','NOT_APPROVED',1,'Anna B.','Seed-Bewertung #65: Produkt wirkt solide.','user65@example.com','MAIL',3),
('P006','0001','APPROVED',2,'Max M.','Seed-Bewertung #66: Produkt wirkt solide.','user66@example.com','INTRANET',NULL),
('P007','0002','APPROVED',3,'Lisa K.','Seed-Bewertung #67: Produkt wirkt solide.','user67@example.com',NULL,NULL),
('P008','0003','APPROVED',4,'Tom R.','Seed-Bewertung #68: Produkt wirkt solide.','user68@example.com','SHOP',NULL),
('P009','0004','APPROVED',5,'Sara W.','Seed-Bewertung #69: Produkt wirkt solide.','user69@example.com','MAIL',NULL),
('P010','0005','PENDING',1,'Anna B.','Seed-Bewertung #70: Produkt wirkt solide.','user70@example.com','INTRANET',NULL),
('P011','0001','APPROVED',2,'Max M.','Seed-Bewertung #71: Produkt wirkt solide.','user71@example.com',NULL,NULL),
('P012','0002','APPROVED',3,'Lisa K.','Seed-Bewertung #72: Produkt wirkt solide.','user72@example.com','SHOP',NULL),
('P013','0003','APPROVED',4,'Tom R.','Seed-Bewertung #73: Produkt wirkt solide.','user73@example.com','MAIL',NULL),
('P014','0004','APPROVED',5,'Sara W.','Seed-Bewertung #74: Produkt wirkt solide.','user74@example.com','INTRANET',NULL),
('P015','0005','APPROVED',1,'Anna B.','Seed-Bewertung #75: Produkt wirkt solide.','user75@example.com',NULL,NULL),
('P016','0001','APPROVED',2,'Max M.','Seed-Bewertung #76: Produkt wirkt solide.','user76@example.com','SHOP',NULL),
('P017','0002','PENDING',3,'Lisa K.','Seed-Bewertung #77: Produkt wirkt solide.','user77@example.com','MAIL',NULL),
('P018','0003','NOT_APPROVED',4,'Tom R.','Seed-Bewertung #78: Produkt wirkt solide.','user78@example.com','INTRANET',1),
('P019','0004','APPROVED',5,'Sara W.','Seed-Bewertung #79: Produkt wirkt solide.','user79@example.com',NULL,NULL),
('P020','0005','APPROVED',1,'Anna B.','Seed-Bewertung #80: Produkt wirkt solide.','user80@example.com','SHOP',NULL),
('P001','0001','APPROVED',2,'Max M.','Seed-Bewertung #81: Produkt wirkt solide.','user81@example.com','MAIL',NULL),
('P002','0002','APPROVED',3,'Lisa K.','Seed-Bewertung #82: Produkt wirkt solide.','user82@example.com','INTRANET',NULL),
('P003','0003','APPROVED',4,'Tom R.','Seed-Bewertung #83: Produkt wirkt solide.','user83@example.com',NULL,NULL),
('P004','0004','PENDING',5,'Sara W.','Seed-Bewertung #84: Produkt wirkt solide.','user84@example.com','SHOP',NULL),
('P005','0005','APPROVED',1,'Anna B.','Seed-Bewertung #85: Produkt wirkt solide.','user85@example.com','MAIL',NULL),
('P006','0001','APPROVED',2,'Max M.','Seed-Bewertung #86: Produkt wirkt solide.','user86@example.com','INTRANET',NULL),
('P007','0002','APPROVED',3,'Lisa K.','Seed-Bewertung #87: Produkt wirkt solide.','user87@example.com',NULL,NULL),
('P008','0003','APPROVED',4,'Tom R.','Seed-Bewertung #88: Produkt wirkt solide.','user88@example.com','SHOP',NULL),
('P009','0004','APPROVED',5,'Sara W.','Seed-Bewertung #89: Produkt wirkt solide.','user89@example.com','MAIL',NULL),
('P010','0005','APPROVED',1,'Anna B.','Seed-Bewertung #90: Produkt wirkt solide.','user90@example.com','INTRANET',NULL),
('P011','0001','PENDING',2,'Max M.','Seed-Bewertung #91: Produkt wirkt solide.','user91@example.com',NULL,NULL),
('P012','0002','APPROVED',3,'Lisa K.','Seed-Bewertung #92: Produkt wirkt solide.','user92@example.com','SHOP',NULL),
('P013','0003','APPROVED',4,'Tom R.','Seed-Bewertung #93: Produkt wirkt solide.','user93@example.com','MAIL',NULL),
('P014','0004','APPROVED',5,'Sara W.','Seed-Bewertung #94: Produkt wirkt solide.','user94@example.com','INTRANET',NULL),
('P015','0005','APPROVED',1,'Anna B.','Seed-Bewertung #95: Produkt wirkt solide.','user95@example.com',NULL,NULL),
('P016','0001','APPROVED',2,'Max M.','Seed-Bewertung #96: Produkt wirkt solide.','user96@example.com','SHOP',NULL),
('P017','0002','APPROVED',3,'Lisa K.','Seed-Bewertung #97: Produkt wirkt solide.','user97@example.com','MAIL',NULL),
('P018','0003','PENDING',4,'Tom R.','Seed-Bewertung #98: Produkt wirkt solide.','user98@example.com','INTRANET',NULL),
('P019','0004','APPROVED',5,'Sara W.','Seed-Bewertung #99: Produkt wirkt solide.','user99@example.com',NULL,NULL),
('P020','0005','APPROVED',1,'Anna B.','Seed-Bewertung #100: Produkt wirkt solide.','user100@example.com','SHOP',NULL);

-- Explicit visibility: one row per store assignment (rating id = row order 1..100)
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (1,'0001'),(1,'0002'),(1,'0003'),(1,'0004'),(1,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (2,'0001'),(2,'0002'),(2,'0003'),(2,'0004'),(2,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (3,'0001'),(3,'0002'),(3,'0003'),(3,'0004'),(3,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (4,'0001'),(4,'0002'),(4,'0003'),(4,'0004'),(4,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (5,'0001'),(5,'0002'),(5,'0003'),(5,'0004'),(5,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (6,'0001'),(6,'0002'),(6,'0003'),(6,'0004'),(6,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (8,'0001'),(8,'0002'),(8,'0003'),(8,'0004'),(8,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (9,'0001'),(9,'0002'),(9,'0003'),(9,'0004'),(9,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (10,'0001'),(10,'0002'),(10,'0003'),(10,'0004'),(10,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (11,'0001'),(11,'0002'),(11,'0003'),(11,'0004'),(11,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (12,'0001'),(12,'0002'),(12,'0003'),(12,'0004'),(12,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (15,'0001'),(15,'0002'),(15,'0003'),(15,'0004'),(15,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (16,'0001'),(16,'0002'),(16,'0003'),(16,'0004'),(16,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (17,'0001'),(17,'0002');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (18,'0001'),(18,'0002'),(18,'0003'),(18,'0004'),(18,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (19,'0001'),(19,'0002'),(19,'0003'),(19,'0004'),(19,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (20,'0001'),(20,'0002'),(20,'0003'),(20,'0004'),(20,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (22,'0001'),(22,'0002'),(22,'0003'),(22,'0004'),(22,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (23,'0001'),(23,'0002'),(23,'0003'),(23,'0004'),(23,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (24,'0001'),(24,'0002'),(24,'0003'),(24,'0004'),(24,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (25,'0001'),(25,'0002'),(25,'0003'),(25,'0004'),(25,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (27,'0001'),(27,'0002'),(27,'0003'),(27,'0004'),(27,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (29,'0001'),(29,'0002'),(29,'0003'),(29,'0004'),(29,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (30,'0001'),(30,'0002'),(30,'0003'),(30,'0004'),(30,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (31,'0001'),(31,'0002'),(31,'0003'),(31,'0004'),(31,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (32,'0001'),(32,'0002'),(32,'0003'),(32,'0004'),(32,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (33,'0001'),(33,'0002'),(33,'0003'),(33,'0004'),(33,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (34,'0001'),(34,'0002');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (36,'0001'),(36,'0002'),(36,'0003'),(36,'0004'),(36,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (37,'0001'),(37,'0002'),(37,'0003'),(37,'0004'),(37,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (38,'0001'),(38,'0002'),(38,'0003'),(38,'0004'),(38,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (40,'0001'),(40,'0002'),(40,'0003'),(40,'0004'),(40,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (41,'0001'),(41,'0002'),(41,'0003'),(41,'0004'),(41,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (43,'0001'),(43,'0002'),(43,'0003'),(43,'0004'),(43,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (44,'0001'),(44,'0002'),(44,'0003'),(44,'0004'),(44,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (45,'0001'),(45,'0002'),(45,'0003'),(45,'0004'),(45,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (46,'0001'),(46,'0002'),(46,'0003'),(46,'0004'),(46,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (47,'0001'),(47,'0002'),(47,'0003'),(47,'0004'),(47,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (48,'0001'),(48,'0002'),(48,'0003'),(48,'0004'),(48,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (50,'0001'),(50,'0002'),(50,'0003'),(50,'0004'),(50,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (51,'0001'),(51,'0002');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (53,'0001'),(53,'0002'),(53,'0003'),(53,'0004'),(53,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (54,'0001'),(54,'0002'),(54,'0003'),(54,'0004'),(54,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (55,'0001'),(55,'0002'),(55,'0003'),(55,'0004'),(55,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (57,'0001'),(57,'0002'),(57,'0003'),(57,'0004'),(57,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (58,'0001'),(58,'0002'),(58,'0003'),(58,'0004'),(58,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (59,'0001'),(59,'0002'),(59,'0003'),(59,'0004'),(59,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (60,'0001'),(60,'0002'),(60,'0003'),(60,'0004'),(60,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (61,'0001'),(61,'0002'),(61,'0003'),(61,'0004'),(61,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (62,'0001'),(62,'0002'),(62,'0003'),(62,'0004'),(62,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (64,'0001'),(64,'0002'),(64,'0003'),(64,'0004'),(64,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (66,'0001'),(66,'0002'),(66,'0003'),(66,'0004'),(66,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (67,'0001'),(67,'0002'),(67,'0003'),(67,'0004'),(67,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (68,'0001'),(68,'0002');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (69,'0001'),(69,'0002'),(69,'0003'),(69,'0004'),(69,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (71,'0001'),(71,'0002'),(71,'0003'),(71,'0004'),(71,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (72,'0001'),(72,'0002'),(72,'0003'),(72,'0004'),(72,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (73,'0001'),(73,'0002'),(73,'0003'),(73,'0004'),(73,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (74,'0001'),(74,'0002'),(74,'0003'),(74,'0004'),(74,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (75,'0001'),(75,'0002'),(75,'0003'),(75,'0004'),(75,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (76,'0001'),(76,'0002'),(76,'0003'),(76,'0004'),(76,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (79,'0001'),(79,'0002'),(79,'0003'),(79,'0004'),(79,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (80,'0001'),(80,'0002'),(80,'0003'),(80,'0004'),(80,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (81,'0001'),(81,'0002'),(81,'0003'),(81,'0004'),(81,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (82,'0001'),(82,'0002'),(82,'0003'),(82,'0004'),(82,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (83,'0001'),(83,'0002'),(83,'0003'),(83,'0004'),(83,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (85,'0001'),(85,'0002');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (86,'0001'),(86,'0002'),(86,'0003'),(86,'0004'),(86,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (87,'0001'),(87,'0002'),(87,'0003'),(87,'0004'),(87,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (88,'0001'),(88,'0002'),(88,'0003'),(88,'0004'),(88,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (89,'0001'),(89,'0002'),(89,'0003'),(89,'0004'),(89,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (90,'0001'),(90,'0002'),(90,'0003'),(90,'0004'),(90,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (92,'0001'),(92,'0002'),(92,'0003'),(92,'0004'),(92,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (93,'0001'),(93,'0002'),(93,'0003'),(93,'0004'),(93,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (94,'0001'),(94,'0002'),(94,'0003'),(94,'0004'),(94,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (95,'0001'),(95,'0002'),(95,'0003'),(95,'0004'),(95,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (96,'0001'),(96,'0002'),(96,'0003'),(96,'0004'),(96,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (97,'0001'),(97,'0002'),(97,'0003'),(97,'0004'),(97,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (99,'0001'),(99,'0002'),(99,'0003'),(99,'0004'),(99,'0005');
INSERT INTO rating_visible_stores (rating_id, store_id) VALUES (100,'0001'),(100,'0002'),(100,'0003'),(100,'0004'),(100,'0005');

INSERT INTO rating_criteria_links (rating_id, criteria_id) SELECT id, 1 FROM ratings WHERE status = 'APPROVED' AND id % 5 = 0;
