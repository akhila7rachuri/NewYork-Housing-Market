-- Clear existing data from tables and reset identity column
TRUNCATE TABLE Properties, Broker, PropertyType, Area, Location, Address RESTART IDENTITY CASCADE;

INSERT INTO Broker (BrokerTitle) SELECT DISTINCT BROKERTITLE FROM Main_table;

INSERT INTO Property Type (TypeName)
SELECT DISTINCT TYPE FROM Main_table;

INSERT INTO Area (AdministrativeAreaLevel2, Sublocality, FormattedAddress) 
SELECT DISTINCT ADMINISTRATIVE AREA LEVEL 2, SUBLOCALITY, FORMATTED ADDRESS FROM Main_table;

INSERT INTO Location (Latitude, Longitude, Locality, AreaID) 
SELECT DISTINCT LATITUDE, LONGITUDE, LOCALITY, Area.AreaID FROM Main_table
JOIN Area ON Main_table.ADMINISTRATIVE_AREA_LEVEL_2 = Area. AdministrativeArealevel2 
AND Main_table.SUBLOCALITY = Area.Sublocality AND Main_table.FORMATTED_ADDRESS = Area.FormattedAddress 
ON CONFLICT (Latitude, Longitude, Locality) DO NOTHING;

INSERT INTO Address (StreetName, MainAddress, LocationID)
SELECT DISTINCT STREET_NAME, MAIN_ADDRESS, Location.LocationID FROM Main_table
JOIN Location ON Main_table.LATITUDE = Location.Latitude AND Main_table.LONGITUDE = Location.Longitude 
AND Main_table.LOCALITY = Location.Locality;

INSERT INTO Properties (Broker ID, TypeID, Price, Beds, Baths, PropertySqFt, AddressID)
SELECT Broker. Broker ID, Property Type. Type ID, PRICE, BEDS, BATH, PROPERTYSQFT, Address.AddressID
FROM Main table
JOIN Broker ON Main table.BROKERTITLE = Broker.brokertitle JOIN PropertyType ON Main table.TYPE= PropertyType.TypeName 
JOIN Address ON Main table.STREET_NAME= Address.StreetName
AND Main table.MAIN_ADDRESS = Address.MainAddress;