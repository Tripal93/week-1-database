-- Create the database with a clear, descriptive name
CREATE DATABASE IF NOT EXISTS library_management_db;
USE library_management_db;

-- 1. Authors table
CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    country VARCHAR(100)
);

-- 2. Books table
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    published_year YEAR,
    total_copies INT NOT NULL DEFAULT 1,
    available_copies INT NOT NULL DEFAULT 1,
    author_id INT NOT NULL,
    CONSTRAINT fk_books_author
        FOREIGN KEY (author_id) REFERENCES authors(author_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_available_copies
        CHECK (available_copies >= 0 AND available_copies <= total_copies)
);

-- 3. Members table
CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(30),
    joined_date DATE NOT NULL DEFAULT (CURRENT_DATE)
);

-- 4. Borrow records (loans) table
CREATE TABLE borrow_records (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    borrowed_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    due_date DATE NOT NULL,
    returned_date DATE NULL,
    CONSTRAINT fk_loans_book
        FOREIGN KEY (book_id) REFERENCES books(book_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_loans_member
        FOREIGN KEY (member_id) REFERENCES members(member_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- Sample data
INSERT INTO authors (first_name, last_name, country) VALUES
    ('Chinua', 'Achebe', 'Nigeria'),
    ('Grace', 'Ogot', 'Kenya'),
    ('George', 'Orwell', 'United Kingdom');

INSERT INTO books (title, isbn, published_year, total_copies, available_copies, author_id) VALUES
    ('Things Fall Apart', '978-0385474542', 1958, 5, 4, 1),
    ('The Promised Land', '978-9966460260', 1966, 3, 3, 2),
    ('1984', '978-0451524935', 1949, 4, 3, 3);

INSERT INTO members (full_name, email, phone, joined_date) VALUES
    ('Amina Hassan', 'amina.hassan@example.com', '+254700000001', '2026-01-15'),
    ('Brian Ochieng', 'brian.ochieng@example.com', '+254700000002', '2026-02-10');

INSERT INTO borrow_records (book_id, member_id, borrowed_date, due_date, returned_date) VALUES
    (1, 1, '2026-11-01', '2026-11-15', NULL),
    (3, 2, '2026-11-05', '2026-11-19', NULL);
