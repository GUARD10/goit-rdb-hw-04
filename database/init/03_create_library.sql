CREATE DATABASE IF NOT EXISTS LibraryManagement CHARACTER SET utf8mb4;
USE LibraryManagement;

CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(100) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    publication_year YEAR,
    author_id INT NOT NULL,
    genre_id INT NOT NULL,
    CONSTRAINT fk_books_authors FOREIGN KEY (author_id) REFERENCES authors(author_id),
    CONSTRAINT fk_books_genres FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
) ENGINE = InnoDB;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE borrowed_books (
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    user_id INT NOT NULL,
    borrow_date DATE NOT NULL,
    return_date DATE NULL,
    CONSTRAINT fk_borrowed_books_books FOREIGN KEY (book_id) REFERENCES books(book_id),
    CONSTRAINT fk_borrowed_books_users FOREIGN KEY (user_id) REFERENCES users(user_id)
) ENGINE = InnoDB;

GRANT ALL PRIVILEGES ON LibraryManagement.* TO 'goit_hw_04'@'%';
