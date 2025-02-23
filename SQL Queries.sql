--1. This query calculates the average property price for each locality
SELECT Location.Locality, round(AVG(Properties.Price)::numeric, 2) AS avg_price
FROM Properties
INNER JOIN Address ON Properties.AddressID = Address.AddressID
INNER JOIN Location ON Address.LocationID = Location.LocationID
INNER JOIN Area ON Location.AreaID = Area.AreaID
GROUP BY Location.Locality
ORDER BY avg_price DESC;

--2. This query identifies brokers who have listed more than 10 properties.
SELECT b.BrokerID, b.BrokerTitle, COUNT(p.PropertyID) AS Properties_Count
FROM Properties p
INNER JOIN Broker b ON p.BrokerID = b.BrokerID
GROUP BY b.BrokerID, b.BrokerTitle
HAVING COUNT(p.PropertyID) > 10
LIMIT 5;

--3. Top 5 localities and sub localities with the highest average property square 
--footage and average price for condos for sale.
SELECT Locality, Sublocality, 
ROUND(AVG(AvgPropertySqFt)::numeric, 2) AS AvgPropertySqFt, 
ROUND(AVG(AvgPrice)::numeric, 2) AS AvgPrice
FROM (
    SELECT Location.Locality, Area.Sublocality, 
    Properties.PropertySqFt AS AvgPropertySqFt, 
    Properties.Price AS AvgPrice
    FROM Area
    JOIN Location ON Area.AreaID = Location.AreaID
    JOIN Address ON Location.LocationID = Address.LocationID
    JOIN Properties ON Address.AddressID = Properties.AddressID
    JOIN PropertyType ON Properties.TypeID = PropertyType.TypeID
    WHERE PropertyType.TypeName = 'Condo for sale'
    GROUP BY Location.Locality, Area.Sublocality, Properties.PropertySqFt, Properties.Price
) AS Subquery
GROUP BY Locality, Sublocality
ORDER BY AvgPropertySqFt DESC
LIMIT 5;

--4.  Are there any properties available within the price range of 
--$100,0000 to $300,0000 in my desired locality? Locality = “Bronx Country”
SELECT Address.StreetName, Address.MainAddress, Properties.Price
FROM Address
JOIN Properties ON Address.AddressID = Properties.AddressID
JOIN Location ON Address.LocationID = Location.LocationID
WHERE Location.Locality = 'Bronx County'
AND Properties.Price BETWEEN 100000 AND 300000;

--5.  Query to identify the average number of 
--bedrooms and bathrooms for each property type
SELECT PropertyType.TypeName AS PropertyType, 
CAST(ROUND(AVG(Properties.Beds)) AS INT) AS AvgBeds, 
CAST(AVG(Properties.Baths) AS INT) AS AvgBaths
FROM PropertyType
LEFT JOIN Properties ON PropertyType.TypeID = Properties.TypeID
GROUP BY PropertyType.TypeName;


UPDATE Area
SET administrativearealevel2 = 'New York'
WHERE sublocality = 'New York';


UPDATE Properties
SET baths = 2
WHERE baths > 2 AND baths < 3;

INSERT INTO Broker (brokertitle)
VALUES ('Brokered by Adams Realty');

DELETE FROM properties
USING broker, propertytype
WHERE properties.brokerid = broker.brokerid
AND properties.typeid = propertytype.typeid
AND propertytype.typename IN ('Pending', 'Coming Soon');


