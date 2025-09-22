Library Management System - Database Schema

This repository contains the SQL schema and ER diagram for a simple Library Management System (LMS) created as part of an SQL Developer internship task.

Files in this Repository
- schema.sql  
  Full schema with CREATE DATABASE and USE statements.  
  Recommended for offline use in tools like MySQL Workbench, MySQL CLI, or XAMPP/MAMP.

- schematoruninonecompiler.sql  
  Simplified schema (no CREATE DATABASE / USE statements).  
  Recommended for online SQL editors like OneCompiler.

- ERD.png  
  Entity-Relationship Diagram of the LMS schema.

- README.md  
  Documentation of the project.

Entities Included
- Core Entities: Publisher, Author, Book, Member, Staff  
- Operational Entities: TransactionRecord (loans), Reservation, Report  
- Junction Table: BookAuthor (for many-to-many relationship between Books and Authors)

How to Run

Option 1: Offline (MySQL Workbench / CLI)
1. Open schema.sql in your SQL client.  
2. Execute the script to create the database LibraryDB with all tables.  
3. Run queries like:
   USE LibraryDB;
   SHOW TABLES;

Option 2: Online (OneCompiler)
1. Open the SQL editor (for example https://www.db-fiddle.com/).  
2. Paste the contents of schematoruninonecompiler.sql.  
3. Run the script to create tables inside the default database.  
4. Test queries like:
   SHOW TABLES;
   DESC Book;
