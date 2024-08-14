--SQL Schema for the Table:

    CREATE TABLE `sample-project-27081998.sample_project.sample_customer` (
        Index INT64,
        CustomerId STRING,
        First_Name STRING,
        Last_Name STRING,
        Company STRING,
        City STRING,
        Country STRING,
        Phone_1 STRING,
        Phone_2 STRING,
        Email STRING,
        Subscription_Date DATE,
        Website STRING
    );


-- Data Transformation:Transform the data to clean it and make it ready for analysis.

--Example SQL Query to Clean and Transform Data:
   
    CREATE OR REPLACE TABLE `sample-project-27081998.sample_project.transformed_customer` AS
    SELECT
        Index,
        CustomerId,
        First_Name,
        Last_Name,
        Company,
        City,
        Country,
        REGEXP_REPLACE(Phone_1, r'\D', '') AS Clean_Phone_1,
        REGEXP_REPLACE(Phone_2, r'\D', '') AS Clean_Phone_2,
        LOWER(Email) AS Clean_Email,
        PARSE_DATE('%d-%m-%Y', Subscription_Date) AS Subscription_Date,
        Website
    FROM
        `sample-project-27081998.sample_project.sample_customer`
    WHERE
        Email IS NOT NULL
        AND Subscription_Date IS NOT NULL;
