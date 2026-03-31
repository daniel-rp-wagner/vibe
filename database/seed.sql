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

INSERT INTO ratings (product_id, origin_store, status, star, author, text, email, source, rejection_reason_id, visible_all_stores) VALUES
('P001','0002','APPROVED',2,'Max M.','Seed-Bewertung #1: Produkt wirkt solide.','user1@example.com','MAIL',NULL,1),
('P002','0003','APPROVED',3,'Lisa K.','Seed-Bewertung #2: Produkt wirkt solide.','user2@example.com','INTRANET',NULL,1),
('P003','0004','APPROVED',4,'Tom R.','Seed-Bewertung #3: Produkt wirkt solide.','user3@example.com',NULL,NULL,1),
('P004','0005','APPROVED',5,'Sara W.','Seed-Bewertung #4: Produkt wirkt solide.','user4@example.com','SHOP',NULL,1),
('P005','0006','APPROVED',1,'Anna B.','Seed-Bewertung #5: Produkt wirkt solide.','user5@example.com','MAIL',NULL,1),
('P006','0007','APPROVED',2,'Max M.','Seed-Bewertung #6: Produkt wirkt solide.','user6@example.com','INTRANET',NULL,1),
('P007','0008','PENDING',3,'Lisa K.','Seed-Bewertung #7: Produkt wirkt solide.','user7@example.com',NULL,NULL,1),
('P008','0009','APPROVED',4,'Tom R.','Seed-Bewertung #8: Produkt wirkt solide.','user8@example.com','SHOP',NULL,1),
('P009','0010','APPROVED',5,'Sara W.','Seed-Bewertung #9: Produkt wirkt solide.','user9@example.com','MAIL',NULL,1),
('P010','0001','APPROVED',1,'Anna B.','Seed-Bewertung #10: Produkt wirkt solide.','user10@example.com','INTRANET',NULL,1),
('P011','0002','APPROVED',2,'Max M.','Seed-Bewertung #11: Produkt wirkt solide.','user11@example.com',NULL,NULL,1),
('P012','0003','APPROVED',3,'Lisa K.','Seed-Bewertung #12: Produkt wirkt solide.','user12@example.com','SHOP',NULL,1),
('P013','0004','NOT_APPROVED',4,'Tom R.','Seed-Bewertung #13: Produkt wirkt solide.','user13@example.com','MAIL',2,1),
('P014','0005','PENDING',5,'Sara W.','Seed-Bewertung #14: Produkt wirkt solide.','user14@example.com','INTRANET',NULL,1),
('P015','0006','APPROVED',1,'Anna B.','Seed-Bewertung #15: Produkt wirkt solide.','user15@example.com',NULL,NULL,1),
('P016','0007','APPROVED',2,'Max M.','Seed-Bewertung #16: Produkt wirkt solide.','user16@example.com','SHOP',NULL,1),
('P017','0008','APPROVED',3,'Lisa K.','Seed-Bewertung #17: Produkt wirkt solide.','user17@example.com','MAIL',NULL,0),
('P018','0009','APPROVED',4,'Tom R.','Seed-Bewertung #18: Produkt wirkt solide.','user18@example.com','INTRANET',NULL,1),
('P019','0010','APPROVED',5,'Sara W.','Seed-Bewertung #19: Produkt wirkt solide.','user19@example.com',NULL,NULL,1),
('P020','0001','APPROVED',1,'Anna B.','Seed-Bewertung #20: Produkt wirkt solide.','user20@example.com','SHOP',NULL,1),
('P001','0002','PENDING',2,'Max M.','Seed-Bewertung #21: Produkt wirkt solide.','user21@example.com','MAIL',NULL,1),
('P002','0003','APPROVED',3,'Lisa K.','Seed-Bewertung #22: Produkt wirkt solide.','user22@example.com','INTRANET',NULL,1),
('P003','0004','APPROVED',4,'Tom R.','Seed-Bewertung #23: Produkt wirkt solide.','user23@example.com',NULL,NULL,1),
('P004','0005','APPROVED',5,'Sara W.','Seed-Bewertung #24: Produkt wirkt solide.','user24@example.com','SHOP',NULL,1),
('P005','0006','APPROVED',1,'Anna B.','Seed-Bewertung #25: Produkt wirkt solide.','user25@example.com','MAIL',NULL,1),
('P006','0007','NOT_APPROVED',2,'Max M.','Seed-Bewertung #26: Produkt wirkt solide.','user26@example.com','INTRANET',3,1),
('P007','0008','APPROVED',3,'Lisa K.','Seed-Bewertung #27: Produkt wirkt solide.','user27@example.com',NULL,NULL,1),
('P008','0009','PENDING',4,'Tom R.','Seed-Bewertung #28: Produkt wirkt solide.','user28@example.com','SHOP',NULL,1),
('P009','0010','APPROVED',5,'Sara W.','Seed-Bewertung #29: Produkt wirkt solide.','user29@example.com','MAIL',NULL,1),
('P010','0001','APPROVED',1,'Anna B.','Seed-Bewertung #30: Produkt wirkt solide.','user30@example.com','INTRANET',NULL,1),
('P011','0002','APPROVED',2,'Max M.','Seed-Bewertung #31: Produkt wirkt solide.','user31@example.com',NULL,NULL,1),
('P012','0003','APPROVED',3,'Lisa K.','Seed-Bewertung #32: Produkt wirkt solide.','user32@example.com','SHOP',NULL,1),
('P013','0004','APPROVED',4,'Tom R.','Seed-Bewertung #33: Produkt wirkt solide.','user33@example.com','MAIL',NULL,1),
('P014','0005','APPROVED',5,'Sara W.','Seed-Bewertung #34: Produkt wirkt solide.','user34@example.com','INTRANET',NULL,0),
('P015','0006','PENDING',1,'Anna B.','Seed-Bewertung #35: Produkt wirkt solide.','user35@example.com',NULL,NULL,1),
('P016','0007','APPROVED',2,'Max M.','Seed-Bewertung #36: Produkt wirkt solide.','user36@example.com','SHOP',NULL,1),
('P017','0008','APPROVED',3,'Lisa K.','Seed-Bewertung #37: Produkt wirkt solide.','user37@example.com','MAIL',NULL,1),
('P018','0009','APPROVED',4,'Tom R.','Seed-Bewertung #38: Produkt wirkt solide.','user38@example.com','INTRANET',NULL,1),
('P019','0010','NOT_APPROVED',5,'Sara W.','Seed-Bewertung #39: Produkt wirkt solide.','user39@example.com',NULL,1,1),
('P020','0001','APPROVED',1,'Anna B.','Seed-Bewertung #40: Produkt wirkt solide.','user40@example.com','SHOP',NULL,1),
('P001','0002','APPROVED',2,'Max M.','Seed-Bewertung #41: Produkt wirkt solide.','user41@example.com','MAIL',NULL,1),
('P002','0003','PENDING',3,'Lisa K.','Seed-Bewertung #42: Produkt wirkt solide.','user42@example.com','INTRANET',NULL,1),
('P003','0004','APPROVED',4,'Tom R.','Seed-Bewertung #43: Produkt wirkt solide.','user43@example.com',NULL,NULL,1),
('P004','0005','APPROVED',5,'Sara W.','Seed-Bewertung #44: Produkt wirkt solide.','user44@example.com','SHOP',NULL,1),
('P005','0006','APPROVED',1,'Anna B.','Seed-Bewertung #45: Produkt wirkt solide.','user45@example.com','MAIL',NULL,1),
('P006','0007','APPROVED',2,'Max M.','Seed-Bewertung #46: Produkt wirkt solide.','user46@example.com','INTRANET',NULL,1),
('P007','0008','APPROVED',3,'Lisa K.','Seed-Bewertung #47: Produkt wirkt solide.','user47@example.com',NULL,NULL,1),
('P008','0009','APPROVED',4,'Tom R.','Seed-Bewertung #48: Produkt wirkt solide.','user48@example.com','SHOP',NULL,1),
('P009','0010','PENDING',5,'Sara W.','Seed-Bewertung #49: Produkt wirkt solide.','user49@example.com','MAIL',NULL,1),
('P010','0001','APPROVED',1,'Anna B.','Seed-Bewertung #50: Produkt wirkt solide.','user50@example.com','INTRANET',NULL,1),
('P011','0002','APPROVED',2,'Max M.','Seed-Bewertung #51: Produkt wirkt solide.','user51@example.com',NULL,NULL,0),
('P012','0003','NOT_APPROVED',3,'Lisa K.','Seed-Bewertung #52: Produkt wirkt solide.','user52@example.com','SHOP',2,1),
('P013','0004','APPROVED',4,'Tom R.','Seed-Bewertung #53: Produkt wirkt solide.','user53@example.com','MAIL',NULL,1),
('P014','0005','APPROVED',5,'Sara W.','Seed-Bewertung #54: Produkt wirkt solide.','user54@example.com','INTRANET',NULL,1),
('P015','0006','APPROVED',1,'Anna B.','Seed-Bewertung #55: Produkt wirkt solide.','user55@example.com',NULL,NULL,1),
('P016','0007','PENDING',2,'Max M.','Seed-Bewertung #56: Produkt wirkt solide.','user56@example.com','SHOP',NULL,1),
('P017','0008','APPROVED',3,'Lisa K.','Seed-Bewertung #57: Produkt wirkt solide.','user57@example.com','MAIL',NULL,1),
('P018','0009','APPROVED',4,'Tom R.','Seed-Bewertung #58: Produkt wirkt solide.','user58@example.com','INTRANET',NULL,1),
('P019','0010','APPROVED',5,'Sara W.','Seed-Bewertung #59: Produkt wirkt solide.','user59@example.com',NULL,NULL,1),
('P020','0001','APPROVED',1,'Anna B.','Seed-Bewertung #60: Produkt wirkt solide.','user60@example.com','SHOP',NULL,1),
('P001','0002','APPROVED',2,'Max M.','Seed-Bewertung #61: Produkt wirkt solide.','user61@example.com','MAIL',NULL,1),
('P002','0003','APPROVED',3,'Lisa K.','Seed-Bewertung #62: Produkt wirkt solide.','user62@example.com','INTRANET',NULL,1),
('P003','0004','PENDING',4,'Tom R.','Seed-Bewertung #63: Produkt wirkt solide.','user63@example.com',NULL,NULL,1),
('P004','0005','APPROVED',5,'Sara W.','Seed-Bewertung #64: Produkt wirkt solide.','user64@example.com','SHOP',NULL,1),
('P005','0006','NOT_APPROVED',1,'Anna B.','Seed-Bewertung #65: Produkt wirkt solide.','user65@example.com','MAIL',3,1),
('P006','0007','APPROVED',2,'Max M.','Seed-Bewertung #66: Produkt wirkt solide.','user66@example.com','INTRANET',NULL,1),
('P007','0008','APPROVED',3,'Lisa K.','Seed-Bewertung #67: Produkt wirkt solide.','user67@example.com',NULL,NULL,1),
('P008','0009','APPROVED',4,'Tom R.','Seed-Bewertung #68: Produkt wirkt solide.','user68@example.com','SHOP',NULL,0),
('P009','0010','APPROVED',5,'Sara W.','Seed-Bewertung #69: Produkt wirkt solide.','user69@example.com','MAIL',NULL,1),
('P010','0001','PENDING',1,'Anna B.','Seed-Bewertung #70: Produkt wirkt solide.','user70@example.com','INTRANET',NULL,1),
('P011','0002','APPROVED',2,'Max M.','Seed-Bewertung #71: Produkt wirkt solide.','user71@example.com',NULL,NULL,1),
('P012','0003','APPROVED',3,'Lisa K.','Seed-Bewertung #72: Produkt wirkt solide.','user72@example.com','SHOP',NULL,1),
('P013','0004','APPROVED',4,'Tom R.','Seed-Bewertung #73: Produkt wirkt solide.','user73@example.com','MAIL',NULL,1),
('P014','0005','APPROVED',5,'Sara W.','Seed-Bewertung #74: Produkt wirkt solide.','user74@example.com','INTRANET',NULL,1),
('P015','0006','APPROVED',1,'Anna B.','Seed-Bewertung #75: Produkt wirkt solide.','user75@example.com',NULL,NULL,1),
('P016','0007','APPROVED',2,'Max M.','Seed-Bewertung #76: Produkt wirkt solide.','user76@example.com','SHOP',NULL,1),
('P017','0008','PENDING',3,'Lisa K.','Seed-Bewertung #77: Produkt wirkt solide.','user77@example.com','MAIL',NULL,1),
('P018','0009','NOT_APPROVED',4,'Tom R.','Seed-Bewertung #78: Produkt wirkt solide.','user78@example.com','INTRANET',1,1),
('P019','0010','APPROVED',5,'Sara W.','Seed-Bewertung #79: Produkt wirkt solide.','user79@example.com',NULL,NULL,1),
('P020','0001','APPROVED',1,'Anna B.','Seed-Bewertung #80: Produkt wirkt solide.','user80@example.com','SHOP',NULL,1),
('P001','0002','APPROVED',2,'Max M.','Seed-Bewertung #81: Produkt wirkt solide.','user81@example.com','MAIL',NULL,1),
('P002','0003','APPROVED',3,'Lisa K.','Seed-Bewertung #82: Produkt wirkt solide.','user82@example.com','INTRANET',NULL,1),
('P003','0004','APPROVED',4,'Tom R.','Seed-Bewertung #83: Produkt wirkt solide.','user83@example.com',NULL,NULL,1),
('P004','0005','PENDING',5,'Sara W.','Seed-Bewertung #84: Produkt wirkt solide.','user84@example.com','SHOP',NULL,1),
('P005','0006','APPROVED',1,'Anna B.','Seed-Bewertung #85: Produkt wirkt solide.','user85@example.com','MAIL',NULL,0),
('P006','0007','APPROVED',2,'Max M.','Seed-Bewertung #86: Produkt wirkt solide.','user86@example.com','INTRANET',NULL,1),
('P007','0008','APPROVED',3,'Lisa K.','Seed-Bewertung #87: Produkt wirkt solide.','user87@example.com',NULL,NULL,1),
('P008','0009','APPROVED',4,'Tom R.','Seed-Bewertung #88: Produkt wirkt solide.','user88@example.com','SHOP',NULL,1),
('P009','0010','APPROVED',5,'Sara W.','Seed-Bewertung #89: Produkt wirkt solide.','user89@example.com','MAIL',NULL,1),
('P010','0001','APPROVED',1,'Anna B.','Seed-Bewertung #90: Produkt wirkt solide.','user90@example.com','INTRANET',NULL,1),
('P011','0002','PENDING',2,'Max M.','Seed-Bewertung #91: Produkt wirkt solide.','user91@example.com',NULL,NULL,1),
('P012','0003','APPROVED',3,'Lisa K.','Seed-Bewertung #92: Produkt wirkt solide.','user92@example.com','SHOP',NULL,1),
('P013','0004','APPROVED',4,'Tom R.','Seed-Bewertung #93: Produkt wirkt solide.','user93@example.com','MAIL',NULL,1),
('P014','0005','APPROVED',5,'Sara W.','Seed-Bewertung #94: Produkt wirkt solide.','user94@example.com','INTRANET',NULL,1),
('P015','0006','APPROVED',1,'Anna B.','Seed-Bewertung #95: Produkt wirkt solide.','user95@example.com',NULL,NULL,1),
('P016','0007','APPROVED',2,'Max M.','Seed-Bewertung #96: Produkt wirkt solide.','user96@example.com','SHOP',NULL,1),
('P017','0008','APPROVED',3,'Lisa K.','Seed-Bewertung #97: Produkt wirkt solide.','user97@example.com','MAIL',NULL,1),
('P018','0009','PENDING',4,'Tom R.','Seed-Bewertung #98: Produkt wirkt solide.','user98@example.com','INTRANET',NULL,1),
('P019','0010','APPROVED',5,'Sara W.','Seed-Bewertung #99: Produkt wirkt solide.','user99@example.com',NULL,NULL,1),
('P020','0001','APPROVED',1,'Anna B.','Seed-Bewertung #100: Produkt wirkt solide.','user100@example.com','SHOP',NULL,1);

INSERT INTO rating_visible_stores (rating_id, store_id) SELECT id, '0001' FROM ratings WHERE visible_all_stores = 0 AND status = 'APPROVED';
INSERT INTO rating_visible_stores (rating_id, store_id) SELECT id, '0002' FROM ratings WHERE visible_all_stores = 0 AND status = 'APPROVED';

INSERT INTO rating_criteria_links (rating_id, criteria_id) SELECT id, 1 FROM ratings WHERE status = 'APPROVED' AND id % 5 = 0;
