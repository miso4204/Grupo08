-- Inserts de producto

INSERT INTO vhs_special_offer (id_special_offers, short_name, description, price, main_image_url, offer_city, latitude, longitude, offer_category, publish_date, end_date, offer_country, service_promo, currency, city, service_provider) 
VALUES (2, 'Pqt San Andres', 'Paquete especial San Andrés', 150000, 'http://url.jpg', 1, -54, -79, 1, '2015-04-03', '2015-04-30', 'AFG', NULL, NULL, NULL, NULL);

INSERT INTO vhs_special_offer (id_special_offers, short_name, description, price, main_image_url, offer_city, latitude, longitude, offer_category, publish_date, end_date, offer_country, service_promo, currency, city, service_provider) 
VALUES (3, 'Pqt Cartagena', 'Paquete especial Cartagena', 175000, 'http://url.jpg', 1, -54, -79, 1, '2015-04-03', '2015-04-30', 'AFG', NULL, NULL, NULL, NULL);

INSERT INTO vhs_special_offer (id_special_offers, short_name, description, price, main_image_url, offer_city, latitude, longitude, offer_category, publish_date, end_date, offer_country, service_promo, currency, city, service_provider) 
VALUES (4, 'Pqt Amazonas', 'Paquete especial Amazonas', 290000, 'http://url.jpg', 1, -54, -79, 1, '2015-04-03', '2015-04-30', 'AFG', NULL, NULL, NULL, NULL);

-- Inserts de Ratings

  -- Ratings del paquete 1

INSERT INTO vhsofferrating(id, comments, email, name, score, special_offer) VALUES (1, 'Comentarios del paquete 2', 'email1@gmail.com', 'Usuario 1', 5, 2);
INSERT INTO vhsofferrating(id, comments, email, name, score, special_offer) VALUES (2, 'Comentarios del paquete 2', 'email2@gmail.com', 'Usuario 2', 4, 2);
INSERT INTO vhsofferrating(id, comments, email, name, score, special_offer) VALUES (3, 'Comentarios del paquete 2', 'email3@gmail.com', 'Usuario 3', 3, 2);
INSERT INTO vhsofferrating(id, comments, email, name, score, special_offer) VALUES (4, 'Comentarios del paquete 2', 'email4@gmail.com', 'Usuario 4', 2, 2);
INSERT INTO vhsofferrating(id, comments, email, name, score, special_offer) VALUES (5, 'Comentarios del paquete 2', 'email5@gmail.com', 'Usuario 5', 3, 2);
INSERT INTO vhsofferrating(id, comments, email, name, score, special_offer) VALUES (6, 'Comentarios del paquete 2', 'email6@gmail.com', 'Usuario 6', 4, 2);
INSERT INTO vhsofferrating(id, comments, email, name, score, special_offer) VALUES (7, 'Comentarios del paquete 2', 'email7@gmail.com', 'Usuario 7', 3, 2);
INSERT INTO vhsofferrating(id, comments, email, name, score, special_offer) VALUES (8, 'Comentarios del paquete 2', 'email8@gmail.com', 'Usuario 8', 3, 2);

-- Ratings del paquete 2

INSERT INTO vhsofferrating(id, comments, email, name, score, special_offer) VALUES (9,  'Comentarios del paquete 3', 'email1@gmail.com', 'Usuario 1', 1, 3);
INSERT INTO vhsofferrating(id, comments, email, name, score, special_offer) VALUES (10, 'Comentarios del paquete 3', 'email2@gmail.com', 'Usuario 2', 2, 3);
INSERT INTO vhsofferrating(id, comments, email, name, score, special_offer) VALUES (11, 'Comentarios del paquete 3', 'email3@gmail.com', 'Usuario 3', 3, 3);
INSERT INTO vhsofferrating(id, comments, email, name, score, special_offer) VALUES (12, 'Comentarios del paquete 3', 'email4@gmail.com', 'Usuario 4', 5, 3);
INSERT INTO vhsofferrating(id, comments, email, name, score, special_offer) VALUES (13, 'Comentarios del paquete 3', 'email5@gmail.com', 'Usuario 5', 2, 3);
INSERT INTO vhsofferrating(id, comments, email, name, score, special_offer) VALUES (14, 'Comentarios del paquete 3', 'email6@gmail.com', 'Usuario 6', 2, 3);
INSERT INTO vhsofferrating(id, comments, email, name, score, special_offer) VALUES (15, 'Comentarios del paquete 3', 'email7@gmail.com', 'Usuario 7', 3, 3);
INSERT INTO vhsofferrating(id, comments, email, name, score, special_offer) VALUES (16, 'Comentarios del paquete 3', 'email8@gmail.com', 'Usuario 8', 5, 3);

-- Ratings del paquete 3

INSERT INTO vhsofferrating(id, comments, email, name, score, special_offer) VALUES (17, 'Comentarios del paquete 4', 'email1@gmail.com', 'Usuario 1', 5, 4);
INSERT INTO vhsofferrating(id, comments, email, name, score, special_offer) VALUES (18, 'Comentarios del paquete 4', 'email2@gmail.com', 'Usuario 2', 5, 4);
INSERT INTO vhsofferrating(id, comments, email, name, score, special_offer) VALUES (19, 'Comentarios del paquete 4', 'email3@gmail.com', 'Usuario 3', 5, 4);
INSERT INTO vhsofferrating(id, comments, email, name, score, special_offer) VALUES (20, 'Comentarios del paquete 4', 'email4@gmail.com', 'Usuario 4', 3, 4);
INSERT INTO vhsofferrating(id, comments, email, name, score, special_offer) VALUES (21, 'Comentarios del paquete 4', 'email5@gmail.com', 'Usuario 5', 3, 4);
INSERT INTO vhsofferrating(id, comments, email, name, score, special_offer) VALUES (22, 'Comentarios del paquete 4', 'email6@gmail.com', 'Usuario 6', 4, 4);
INSERT INTO vhsofferrating(id, comments, email, name, score, special_offer) VALUES (23, 'Comentarios del paquete 4', 'email7@gmail.com', 'Usuario 7', 4, 4);
INSERT INTO vhsofferrating(id, comments, email, name, score, special_offer) VALUES (24, 'Comentarios del paquete 4', 'email8@gmail.com', 'Usuario 8', 2, 4);


-- Consulta para obtener el rating por producto

SELECT vso.short_name, AVG(vor.score)
FROM  vhs_special_offer vso
  INNER JOIN vhsofferrating vor ON vor.special_offer = vso.id_special_offers
WHERE vso.publish_date BETWEEN '2013-01-01' AND '2016-01-01'
GROUP BY vso.short_name