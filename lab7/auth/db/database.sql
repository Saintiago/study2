CREATE DATABASE user;

USE user;

CREATE TABLE user
(
  user_id INT(11) UNSIGNED AUTO_INCREMENT,
  login VARCHAR(255),
  password VARCHAR(255),
  PRIMARY KEY (user_id)
);

INSERT INTO user
(login, password)
VALUES
('Paul', '12345'),
('Sarah', 'qwerty'),
('Alexey', 'password');