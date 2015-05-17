CREATE DATABASE rental;

USE rental;

CREATE TABLE dvd
(
  dvd_id INT(11) UNSIGNED AUTO_INCREMENT,
  title VARCHAR(255),
  production_year YEAR,
  PRIMARY KEY (dvd_id)
);

CREATE TABLE customer
(
  customer_id INT(11) UNSIGNED AUTO_INCREMENT,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  passport_code INT(10),
  registration_date DATE,
  PRIMARY KEY (customer_id)
);

CREATE TABLE offer
(
  offer_id INT(11) UNSIGNED AUTO_INCREMENT,
  dvd_id INT(11) UNSIGNED,
  customer_id INT(11) UNSIGNED,
  offer_date DATE,
  return_date DATE,
  PRIMARY KEY (offer_id)
);

INSERT INTO dvd
(title, production_year)
VALUES
('Die hard', 1989),
('Lethal weapon', 1990),
('Terminator', 1992);

INSERT INTO customer
(first_name, last_name, passport_code, registration_date)
VALUES
("John", "Smith", 1234567890, '2000-05-12'),
("Jack", "Johnson", 1234567890, '2000-03-13'),
("Steven", "Spielberg", 1234567890, '2000-07-01');

INSERT INTO offer
(dvd_id, customer_id, offer_date, return_date)
VALUES
(1, 1, '2015-2-15', '2015-2-16'),
(2, 2, '2014-3-14', '2014-3-15'),
(3, 3, '2015-5-13', '2015-5-14');

SELECT * FROM dvd WHERE production_year = 2010 ORDER BY title DESC;

SELECT * FROM dvd WHERE dvd_id IN (SELECT dvd_id FROM offer WHERE return_date > NOW());

SELECT c.last_name, c.first_name, o.offer_date, d.title 
FROM offer AS o
INNER JOIN customer AS c 
ON c.customer_id = o.customer_id
INNER JOIN dvd AS d 
ON d.dvd_id = o.dvd_id 
WHERE YEAR(o.offer_date) = YEAR(NOW()); 