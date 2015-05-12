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
('John', 'Smith', 1234567890, 2000-05-12),
('Jack', 'Johnson', 1234567890, 2000-03-13),
('Steven', 'Spielberg', 1234567890, 2000-07-01);

INSERT INTO offer
(dvd_id, customer_id, offer_date, return_date)
VALUES
(1, 1, 2000-02-15, 2000-02-16),
(2, 2, 2000-03-14, 2000-03-15),
(3, 3, 2000-05-13, 2000-05-14);

SELECT * FROM dvd WHERE production_year = 2010 ORDER BY name DESC;

SELECT * FROM dvd WHERE dvd_id IN (SELECT dvd_id FROM offer WHERE return_date > NOW());

SELECT customer.name, customer.offer_date, dvd.name FROM (dvd JOIN customer ON dvd_id = dvd_id) WHERE YEAR(customer.offer_date) = YEAR(NOW()); 