-- Publisher
CREATE TABLE Publisher (
  publisher_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  address VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Author
CREATE TABLE Author (
  author_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  bio TEXT,
  nationality VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Book
CREATE TABLE Book (
  book_id INT AUTO_INCREMENT PRIMARY KEY,
  isbn VARCHAR(20) UNIQUE,
  title VARCHAR(255) NOT NULL,
  publisher_id INT,
  published_year YEAR,
  copies_total INT DEFAULT 1,
  copies_available INT DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (publisher_id) REFERENCES Publisher(publisher_id)
);

-- Junction table for many-to-many Book <> Author
CREATE TABLE BookAuthor (
  book_id INT NOT NULL,
  author_id INT NOT NULL,
  PRIMARY KEY (book_id, author_id),
  FOREIGN KEY (book_id) REFERENCES Book(book_id) ON DELETE CASCADE,
  FOREIGN KEY (author_id) REFERENCES Author(author_id) ON DELETE CASCADE
);

-- Member
CREATE TABLE Member (
  member_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  email VARCHAR(150) UNIQUE,
  phone VARCHAR(20),
  membership_type ENUM('Student','Teacher','Public','Other') DEFAULT 'Public',
  registered_on DATE
);

-- Staff
CREATE TABLE Staff (
  staff_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  email VARCHAR(150) UNIQUE,
  role VARCHAR(50),
  hired_on DATE,
  active BOOLEAN DEFAULT TRUE
);

-- Transaction / Loan
CREATE TABLE TransactionRecord (
  transaction_id INT AUTO_INCREMENT PRIMARY KEY,
  member_id INT NOT NULL,
  book_id INT NOT NULL,
  staff_id INT,
  loan_date DATE NOT NULL,
  due_date DATE NOT NULL,
  return_date DATE,
  status ENUM('Loaned','Returned','Overdue') DEFAULT 'Loaned',
  FOREIGN KEY (member_id) REFERENCES Member(member_id),
  FOREIGN KEY (book_id) REFERENCES Book(book_id),
  FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
);

-- Reservation
CREATE TABLE Reservation (
  reservation_id INT AUTO_INCREMENT PRIMARY KEY,
  member_id INT NOT NULL,
  book_id INT NOT NULL,
  reserved_on DATE NOT NULL,
  status ENUM('Pending','Fulfilled','Cancelled') DEFAULT 'Pending',
  FOREIGN KEY (member_id) REFERENCES Member(member_id),
  FOREIGN KEY (book_id) REFERENCES Book(book_id)
);

-- Report
CREATE TABLE Report (
  report_id INT AUTO_INCREMENT PRIMARY KEY,
  staff_id INT,
  report_type VARCHAR(100),
  description TEXT,
  created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
);