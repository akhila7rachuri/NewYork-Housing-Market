-- Drop existing tables if they exist
DROP TABLE IF EXISTS main_table;
DROP TABLE IF EXISTS Properties CASCADE;
DROP TABLE IF EXISTS Broker CASCADE;
DROP TABLE IF EXISTS PropertyType CASCADE;
DROP TABLE IF EXISTS Area CASCADE;
DROP TABLE IF EXISTS Location CASCADE;
DROP TABLE IF EXISTS Address CASCADE;


CREATE TABLE IF NOT EXISTS main_table (
    BROKERTITLE VARCHAR(255),
    TYPE VARCHAR(50),
    PRICE DECIMAL,
    BEDS INT,
    BATH DECIMAL,
    PROPERTYSQFT DECIMAL,
    ADDRESS VARCHAR(255),
    STATE VARCHAR(50),
    MAIN_ADDRESS VARCHAR(255),
    ADMINISTRATIVE_AREA_LEVEL_2 VARCHAR(100),
    LOCALITY VARCHAR(100),
    SUBLOCALITY VARCHAR(100),
    STREET_NAME VARCHAR(100),
    LONG_NAME VARCHAR(255),
    FORMATTED_ADDRESS VARCHAR(255),
    LATITUDE DECIMAL,
    LONGITUDE DECIMAL
);



CREATE TABLE Broker (
    BrokerID SERIAL PRIMARY KEY,
    BrokerTitle VARCHAR (255) UNIQUE);

CREATE TABLE PropertyType (
    TypeID SERIAL PRIMARY KEY,
    TypeName VARCHAR (255) UNIQUE );

CREATE TABLE Area (
    AreaID SERIAL PRIMARY KEY,
    AdministrativeAreaLevel2 VARCHAR (255),
    Sublocality VARCHAR (255),
    FormattedAddress VARCHAR (255),
    UNIQUE (AdministrativeAreaLevel2, Sublocality, FormattedAddress));

CREATE TABLE Location (
    LocationID SERIAL PRIMARY KEY,
    Latitude DECIMAL,
    Longitude DECIMAL,
    Locality VARCHAR (255),
    AreaID INT,
    FOREIGN KEY (AreaID) REFERENCES Area (AreaID),
    UNIQUE (Latitude, Longitude, Locality));

CREATE TABLE Address (
    AddressID SERIAL PRIMARY KEY,
    StreetName VARCHAR(255),
    MainAddress VARCHAR(255),
    LocationID INT,
    FOREIGN KEY (LocationID) REFERENCES Location(LocationID),
    UNIQUE (StreetName, MainAddress));

CREATE TABLE Properties (
    PropertyID SERIAL PRIMARY KEY,
    BrokerID INT,
    TypeID INT,
    Price DECIMAL,
    Beds INT,
    Baths DECIMAL,
    PropertySqFt DECIMAL,
    AddressID INT,
    FOREIGN KEY (BrokerID) REFERENCES Broker (BrokerID),
    FOREIGN KEY (TypeID) REFERENCES PropertyType (TypeID),
    FOREIGN KEY (AddressID) REFERENCES Address (AddressID));
