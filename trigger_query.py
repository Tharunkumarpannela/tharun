#Cloud Function to trigger your query:
from google.cloud import bigquery
     def trigger_bq(event, context):
         client = bigquery.Client()
         query = """
         CREATE OR REPLACE TABLE `sample-project-27081998.sample_project.transformed_customer` AS
         SELECT Index, CustomerId, First_Name, Last_Name, Company, City, Country,
         REGEXP_REPLACE(Phone_1, r'\\D', '') AS Clean_Phone_1,
         REGEXP_REPLACE(Phone_2, r'\\D', '') AS Clean_Phone_2,
         LOWER(Email) AS Clean_Email,
         PARSE_DATE('%d-%m-%Y', Subscription_Date) AS Subscription_Date,
         Website FROM `sample-project-27081998.sample_project.sample_customer`
         WHERE Email IS NOT NULL AND Subscription_Date IS NOT NULL;
         """
         client.query(query).result()
