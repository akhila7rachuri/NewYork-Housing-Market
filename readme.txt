Introduction
This project aims to design and implement a database schema to manage information related to the New York housing market. 
The database schema is crafted to enhance data integrity, minimize redundancy, and streamline the querying and management of housing data.

Files Included
create.sql: This file comprises SQL queries to create the database schema, including tables for brokers, property types, areas, locations, addresses, and properties.
load.sql: This file contains SQL queries to populate the created tables with data extracted from the New York Housing Dataset in CSV format.
readme.txt: This document provides an overview of the project, including instructions on using the provided SQL files to set up the database and import and populate data.


Usage
Database Setup: Execute the queries in create.sql to create the necessary tables and establish relationships.
Data Import: Import the New York Housing Dataset into a temporary table named main_table in your PostgreSQL database.
Data Population: Execute the queries in load.sql to insert data from the temporary table into the created tables.
Querying: Once the database is populated, you can perform various queries to retrieve information about brokers, property types, areas, locations, addresses, and properties.
User Interface : User can search their desired results by querying the database


Instructions
Ensure you have a PostgreSQL database server installed and operational.
Connect to your PostgreSQL server using a suitable client (e.g., psql).
Execute the queries in create.sql to create the database schema.
Import the CSV data into a temporary table named main_table using the appropriate PostgreSQL command.