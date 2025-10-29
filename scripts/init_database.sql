/*
=================================================================================================
Create database ans Schemas
=================================================================================================
Scripts Purpose:
  This scripts create a new database named 'DataWarehouse' database  after checking if it already exists.
  If the database exists it is dropped and recreated. Additionally the script sets up three schemas within 
  the database bronze Silver and Gold.
WORNING:
  Running this script will top the entire data warehouse database if it exists. 
  All data in the database will be permanently deleted.
  Proceed with caution and ensure you have proper backups before running the script.
  */


-- Create a Database "DataWarehouse"

USE master;
GO

-- If there existed DATABASE names DataWarehouse drop it and recreate 
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;
GO

-- create database 'DataWarehouse' 

CREATE DATABASE DataWarehouse;
GO
USE DataWarehouse;
GO

-- create data schemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
