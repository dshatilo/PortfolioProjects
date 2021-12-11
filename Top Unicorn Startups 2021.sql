SELECT * FROM unicorns;

SHOW COLUMNS FROM unicorns;

-- Renaming several columns

ALTER TABLE unicorns
RENAME COLUMN MyUnknownColumn TO nb; 

ALTER TABLE unicorns
RENAME COLUMN `Valuation ($B)` TO Valuation;

-- Remove $ sign from the Valuation column

UPDATE unicorns SET Valuation = REPLACE(Valuation, '$', ' ');

-- Modify one of the industry names in the Industry column

UPDATE unicorns SET Industry = REPLACE(Industry, 'Finttech', 'Fintech');

-- Change Valuation column type from text to float

ALTER TABLE unicorns 
MODIFY Valuation float;

-- Looking at the top industry with the biggest share of Valuation
SELECT 
    industry,
    SUM(valuation),
    COUNT(valuation),
    SUM(valuation) / COUNT(valuation)
FROM
    unicorns
GROUP BY industry
ORDER BY SUM(valuation) DESC;

-- Looking at the top country with the biggest share of Valuation
SELECT 
    country,
    SUM(valuation),
    COUNT(valuation),
    SUM(valuation) / COUNT(valuation)
FROM
    unicorns
GROUP BY country
ORDER BY SUM(valuation) DESC;

-- Looking at the amount of private companies valued at over $10 billion
SELECT 
    *,
    (SELECT 
            COUNT(company)
        FROM
            unicorns
        WHERE
            Valuation > 10) AS "Total nb. of companies"
FROM
    unicorns
WHERE
    Valuation > 10;
    
-- Looking at the top city with the biggest share of Valuation
SELECT 
    city, SUM(valuation), COUNT(valuation),SUM(valuation)/COUNT(valuation)
FROM
    unicorns
GROUP BY city
ORDER BY SUM(valuation) DESC;


-- TEMP TABLE
DROP TABLE if exists Industry;
Create Table Industry
(Industries varchar(255),
Valuation float(20),
Companies int(20),
total int(20));

INSERT INTO industry
SELECT 
    industry,
    SUM(valuation),
    COUNT(valuation),
    SUM(valuation) / COUNT(valuation)
FROM
    unicorns
GROUP BY industry
ORDER BY SUM(valuation) DESC;


-- Creating View to store data for later visualizations

Create view Industries AS
SELECT 
    industry,
    SUM(valuation),
    COUNT(valuation)
FROM
    unicorns
GROUP BY industry
ORDER BY SUM(valuation) DESC;

