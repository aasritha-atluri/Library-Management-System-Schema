Library Management System - Database Schema

This repository contains the SQL schema and ER diagram for a simple Library Management System (LMS) created for an SQL Developer internship task.

Files
- 'schema.sql' — SQL script to create the database and all tables, relationships and constraints.
- 'ERD.png' — ER diagram visualizing entities and relationships (exported from dbdiagram.io or MySQL Workbench).
- 'README.md' — This file.

Entities
- Publisher, Author, Book, Member, Staff, TransactionRecord (loans), Reservation, Report
- Many-to-many: Book <-> Author using BookAuthor junction table.

How to run
1. Install MySQL and MySQL Workbench (or any MySQL client).
2. Run 'schema.sql' in your MySQL client to create the 'LibraryDB' schema and tables:
   '''sql
   SOURCE path/to/schema.sql;
