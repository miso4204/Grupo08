-- Inserts de producto

INSERT INTO VHSSpecialOffer VALUES ('Pqt San Andres', 'Paquete especial San Andrés', 150000, 'http://url.jpg', -54, -79, '13-04-2015', '13-05-2015', false, null, 1, 'San Andrés', 'USD')
INSERT INTO VHSSpecialOffer VALUES ('Pqt Cartagena', 'Paquete especial Cartagena', 175000, 'http://url.jpg', -54, -79, '13-01-2015', '13-03-2015', false, null, 1, 'San Andrés', 'USD')
INSERT INTO VHSSpecialOffer VALUES ('Pqt Amazonas', 'Paquete especial Amazonas', 290000, 'http://url.jpg', -54, -79, '13-02-2015', '25-02-2015', false, null, 1, 'San Andrés', 'USD')

-- Inserts de Ratings

  -- Ratings del paquete 1

INSERT INTO VHSOfferRating VALUES (1, 'email1@gmail.com', 'Usuario 1', 'Comentarios del paquete', 5, 1)
INSERT INTO VHSOfferRating VALUES (2, 'email2@gmail.com', 'Usuario 2', 'Comentarios del paquete', 4, 1)
INSERT INTO VHSOfferRating VALUES (3, 'email3@gmail.com', 'Usuario 3', 'Comentarios del paquete', 3, 1)
INSERT INTO VHSOfferRating VALUES (4, 'email4@gmail.com', 'Usuario 4', 'Comentarios del paquete', 2, 1)
INSERT INTO VHSOfferRating VALUES (5, 'email5@gmail.com', 'Usuario 5', 'Comentarios del paquete', 3, 1)
INSERT INTO VHSOfferRating VALUES (6, 'email6@gmail.com', 'Usuario 6', 'Comentarios del paquete', 4, 1)
INSERT INTO VHSOfferRating VALUES (7, 'email7@gmail.com', 'Usuario 7', 'Comentarios del paquete', 3, 1)
INSERT INTO VHSOfferRating VALUES (8, 'email8@gmail.com', 'Usuario 8', 'Comentarios del paquete', 3, 1)

-- Ratings del paquete 2

INSERT INTO VHSOfferRating VALUES (9, 'email1@gmail.com', 'Usuario 1', 'Comentarios del paquete', 1, 2)
INSERT INTO VHSOfferRating VALUES (10, 'email2@gmail.com', 'Usuario 2', 'Comentarios del paquete', 2, 2)
INSERT INTO VHSOfferRating VALUES (11, 'email3@gmail.com', 'Usuario 3', 'Comentarios del paquete', 3, 2)
INSERT INTO VHSOfferRating VALUES (12, 'email4@gmail.com', 'Usuario 4', 'Comentarios del paquete', 5, 2)
INSERT INTO VHSOfferRating VALUES (13, 'email5@gmail.com', 'Usuario 5', 'Comentarios del paquete', 2, 2)
INSERT INTO VHSOfferRating VALUES (14, 'email6@gmail.com', 'Usuario 6', 'Comentarios del paquete', 2, 2)
INSERT INTO VHSOfferRating VALUES (15, 'email7@gmail.com', 'Usuario 7', 'Comentarios del paquete', 3, 2)
INSERT INTO VHSOfferRating VALUES (16, 'email8@gmail.com', 'Usuario 8', 'Comentarios del paquete', 5, 2)

-- Ratings del paquete 3

INSERT INTO VHSOfferRating VALUES (17, 'email1@gmail.com', 'Usuario 1', 'Comentarios del paquete', 5, 3)
INSERT INTO VHSOfferRating VALUES (18, 'email2@gmail.com', 'Usuario 2', 'Comentarios del paquete', 5, 3)
INSERT INTO VHSOfferRating VALUES (19, 'email3@gmail.com', 'Usuario 3', 'Comentarios del paquete', 5, 3)
INSERT INTO VHSOfferRating VALUES (20, 'email4@gmail.com', 'Usuario 4', 'Comentarios del paquete', 3, 3)
INSERT INTO VHSOfferRating VALUES (21, 'email5@gmail.com', 'Usuario 5', 'Comentarios del paquete', 3, 3)
INSERT INTO VHSOfferRating VALUES (22, 'email6@gmail.com', 'Usuario 6', 'Comentarios del paquete', 4, 3)
INSERT INTO VHSOfferRating VALUES (23, 'email7@gmail.com', 'Usuario 7', 'Comentarios del paquete', 4, 3)

-- Consulta para obtener el rating por producto

SELECT vso.shortName, AVG(vor.score)
FROM  VHSSpecialOffer vso
  INNER JOIN VHSOfferRating vor ON vor.specialOffer = vso.idSpecialOffers
WHERE publishDate = '13-04-2015' AND endDate = '13-05-2015'
GROUP BY vso.shortName