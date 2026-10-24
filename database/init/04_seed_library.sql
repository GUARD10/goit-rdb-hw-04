USE LibraryManagement;

INSERT INTO authors (author_name) VALUES ('Olena Lisova'), ('Taras Zorianyi');
INSERT INTO genres (genre_name) VALUES ('Fantasy'), ('Adventure');
INSERT INTO books (title, publication_year, author_id, genre_id) VALUES
    ('The Silver Forest', 2020, 1, 1),
    ('Beyond the Horizon', 2023, 2, 2);
INSERT INTO users (username, email) VALUES
    ('anna_reader', 'anna@example.com'),
    ('maks_reader', 'maks@example.com');
INSERT INTO borrowed_books (book_id, user_id, borrow_date, return_date) VALUES
    (1, 1, '2026-10-01', '2026-10-15'),
    (2, 2, '2026-10-20', NULL);
