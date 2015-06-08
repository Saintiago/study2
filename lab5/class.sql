CREATE DATABASE library;

USE library;

CREATE TABLE book
(
book_id INT(11) UNSIGNED AUTO_INCREMENT,
title VARCHAR(255),
author VARCHAR(255),
publisher VARCHAR(255),
PRIMARY KEY (book_id) 
);

CREATE TABLE storage
(
storage_id INT(11) UNSIGNED AUTO_INCREMENT,
address VARCHAR(255),
PRIMARY KEY (storage_id) 
);

CREATE TABLE storage_book
(
storage_book_id INT(11) UNSIGNED AUTO_INCREMENT,
storage_id INT(11) UNSIGNED,
book_id INT(11) UNSIGNED,
qnt INT(11) UNSIGNED,
PRIMARY KEY (storage_book_id) 
);

INSERT INTO book
(title, author, publisher)
VALUES
('Prestuplenie', 'Dostoevsky', 'AST'), 
('Harry Potter', 'J.K. Rowling', 'AST'),
('Osnovanie', 'Azimov', 'AST'),
('Statsky', 'Akunin', 'AST');

INSERT INTO storage
(address)
VALUES
('Pervomay 118'),
('Soviet 100'),
('Gagarin 17');

INSERT INTO storage_book
(storage_id, book_id, qnt)
VALUES
(1, 2, 5),
(2, 1, 1),
(NULL, 1, 2);

ALTER TABLE storage_book
ADD FOREIGN KEY (storage_id)
    REFERENCES storage (storage_id)
    ON DELETE CASCADE;

ALTER TABLE storage_book
ADD FOREIGN KEY (book_id)
    REFERENCES book (book_id)
    ON DELETE CASCADE;

SELECT title 
FROM book
WHERE book_id IN
(
    SELECT storage_book_id
    FROM storage_book
    GROUP BY book_id
    HAVING COUNT(*) = 1
);

SELECT b.title, sb.qnt 
FROM book b
JOIN storage_book AS sb ON (sb.book_id = b.book_id)
JOIN storage AS s ON (s.storage_id = sb.storage_id)
WHERE
    s.address = 'Pervomay 118';

SELECT s.storage_id, sb.book_id
FROM storage s
INNER JOIN storage_book sb USING (storage_id);

SELECT b.title
FROM book b
INNER JOIN storage_book sb USING (book_id)
WHERE
    sb.qnt > 2;