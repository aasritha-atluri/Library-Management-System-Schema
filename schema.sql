-- schema.sql
-- Library Management System Schema (MySQL)

CREATE DATABASE IF NOT EXISTS LibraryDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;
USE LibraryDB;

-- Publisher
CREATE TABLE IF NOT EXISTS Publisher (
  publisher_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  address VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Author
CREATE TABLE IF NOT EXISTS Author (
  author_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  bio TEXT,
  nationality VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Book
CREATE TABLE IF NOT EXISTS Book (
  book_id INT AUTO_INCREMENT PRIMARY KEY,
  isbn VARCHAR(20) UNIQUE,
  title VARCHAR(255) NOT NULL,
  publisher_id INT,
  published_year YEAR,
  copies_total INT DEFAULT 1,
  copies_available INT DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_book_publisher FOREIGN KEY (publisher_id)
    REFERENCES Publisher(publisher_id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Junction table for many-to-many Book <> Author
CREATE TABLE IF NOT EXISTS BookAuthor (
  book_id INT NOT NULL,
  author_id INT NOT NULL,
  PRIMARY KEY (book_id, author_id),
  FOREIGN KEY (book_id) REFERENCES Book(book_id) ON DELETE CASCADE,
  FOREIGN KEY (author_id) REFERENCES Author(author_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Member
CREATE TABLE IF NOT EXISTS Member (
  member_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  email VARCHAR(150) UNIQUE,
  phone VARCHAR(20),
  membership_type ENUM('Student','Teacher','Public','Other') DEFAULT 'Public',
  registered_on DATE DEFAULT CURRENT_DATE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Staff (Librarians)
CREATE TABLE IF NOT EXISTS Staff (
  staff_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  email VARCHAR(150) UNIQUE,
  role VARCHAR(50),
  hired_on DATE,
  active BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Transaction / Loan
CREATE TABLE IF NOT EXISTS TransactionRecord (
  transaction_id INT AUTO_INCREMENT PRIMARY KEY,
  member_id INT NOT NULL,
  book_id INT NOT NULL,
  staff_id INT,
  loan_date DATE NOT NULL DEFAULT CURRENT_DATE,
  due_date DATE NOT NULL,
  return_date DATE,
  status ENUM('Loaned','Returned','Overdue') DEFAULT 'Loaned',
  FOREIGN KEY (member_id) REFERENCES Member(member_id) ON DELETE RESTRICT,
  FOREIGN KEY (book_id) REFERENCES Book(book_id) ON DELETE RESTRICT,
  FOREIGN KEY (staff_id) REFERENCES Staff(staff_id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Reservation
CREATE TABLE IF NOT EXISTS Reservation (
  reservation_id INT AUTO_INCREMENT PRIMARY KEY,
  member_id INT NOT NULL,
  book_id INT NOT NULL,
  reserved_on DATE NOT NULL DEFAULT CURRENT_DATE,
  status ENUM('Pending','Fulfilled','Cancelled') DEFAULT 'Pending',
  FOREIGN KEY (member_id) REFERENCES Member(member_id) ON DELETE CASCADE,
  FOREIGN KEY (book_id) REFERENCES Book(book_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Report
CREATE TABLE IF NOT EXISTS Report (
  report_id INT AUTO_INCREMENT PRIMARY KEY,
  staff_id INT,
  report_type VARCHAR(100),
  description TEXT,
  created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (staff_id) REFERENCES Staff(staff_id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
