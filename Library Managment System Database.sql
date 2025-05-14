CREATE DATABASE library_db;
USE library_db;
-- Create Authors table
CREATE TABLE Authors (
    authorID INT AUTO_INCREMENT PRIMARY KEY,  -- Primary Key for Authors
    firstName VARCHAR(100) NOT NULL,  -- Author's first name
    lastName VARCHAR(100) NOT NULL,  -- Author's last name
    UNIQUE(firstName, lastName)  -- Ensure no duplicate authors
);

-- Create Books table
CREATE TABLE Books (
    bookID INT AUTO_INCREMENT PRIMARY KEY,  -- Primary Key for Books
    title VARCHAR(255) NOT NULL,  -- Book title
    publishYear INT,  -- Year the book was published
    genre VARCHAR(100),  -- Genre of the book
    availableCopies INT DEFAULT 0 NOT NULL,  -- Number of available copies in the library
    UNIQUE(title)  -- Ensure no duplicate books with the same title
);

-- Create Members table
CREATE TABLE Members (
    memberID INT AUTO_INCREMENT PRIMARY KEY,  -- Primary Key for Members
    firstName VARCHAR(100) NOT NULL,  -- Member's first name
    lastName VARCHAR(100) NOT NULL,  -- Member's last name
    email VARCHAR(100) NOT NULL UNIQUE,  -- Member's email (unique)
    membershipDate DATE DEFAULT (CURRENT_DATE)  -- Date of membership registration
);

-- Create Transactions table
CREATE TABLE Transactions (
    transactionID INT AUTO_INCREMENT PRIMARY KEY,  -- Primary Key for Transactions
    memberID INT,  -- Foreign Key referencing Members
    bookID INT,  -- Foreign Key referencing Books
    borrowDate DATE DEFAULT (CURRENT_DATE),  -- Date when the book is borrowed
    returnDate DATE,  -- Date when the book is returned (can be NULL until returned)
    FOREIGN KEY (memberID) REFERENCES Members(memberID) ON DELETE CASCADE,
    FOREIGN KEY (bookID) REFERENCES Books(bookID) ON DELETE CASCADE
);


-- Create Book_Author table for many-to-many relationship between Books and Authors
CREATE TABLE Book_Author (
    bookID INT,  -- Foreign Key referencing Books
    authorID INT,  -- Foreign Key referencing Authors
    PRIMARY KEY (bookID, authorID),  -- Composite Primary Key
    FOREIGN KEY (bookID) REFERENCES Books(bookID) ON DELETE CASCADE,
    FOREIGN KEY (authorID) REFERENCES Authors(authorID) ON DELETE CASCADE
);

-- Sample Data Insertion (for testing purposes)
-- Inserting Authors
INSERT INTO Authors (firstName, lastName) VALUES ('J.K.', 'Rowling');
INSERT INTO Authors (firstName, lastName) VALUES ('George', 'Orwell');

-- Inserting Books
INSERT INTO Books (title, publishYear, genre, availableCopies) VALUES ('Harry Potter and the Philosopher\'s Stone', 1997, 'Fantasy', 5);
INSERT INTO Books (title, publishYear, genre, availableCopies) VALUES ('1984', 1949, 'Dystopian', 3);

-- Inserting Members
INSERT INTO Members (firstName, lastName, email) VALUES ('John', 'Doe', 'john.doe@example.com');
INSERT INTO Members (firstName, lastName, email) VALUES ('Jane', 'Smith', 'jane.smith@example.com');

-- Inserting Transactions (book borrowings)
INSERT INTO Transactions (memberID, bookID) VALUES (1, 1);  -- John Doe borrows "Harry Potter"
INSERT INTO Transactions (memberID, bookID) VALUES (2, 2);  -- Jane Smith borrows "1984"

-- Inserting Book_Author relationships
INSERT INTO Book_Author (bookID, authorID) VALUES (1, 1);  -- "Harry Potter" by J.K. Rowling
INSERT INTO Book_Author (bookID, authorID) VALUES (2, 2);  -- "1984" by George Orwell
