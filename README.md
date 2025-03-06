# dbt BigQuery ELT Data Pipeline

## Project Overview

This project is a dbt (Data Build Tool) implementation for Google BigQuery, enabling data transformations and ETL workflows within a cloud environment. It integrates Google Cloud Storage (GCS) and BigQuery to process and store large datasets efficiently.

## Project Structure
```
/dbt_bigquery_project
│── models/                     # Stores all dbt models
│── analyses/                   # Stores SQL-based analyses
│── tests/                      # Stores dbt test configurations
│── seeds/                      # Stores seed data for dbt
│── macros/                     # Stores reusable macros
│── snapshots/                  # Stores snapshot configurations
│── dbt_project.yml             # Main dbt configuration file
│── .env                        # Environment variables for project setup
│── sources.yml                 # BigQuery source definitions
│── python_gcp_scripts/          # Python Scripts to extract and load data
```

## Configuration Details

### Environment Variables (.env)

This project uses environment variables stored in a .env file for configuration:
```
PROJECT_ID=ADD_PROJECT_ID_HERE
BIGQUERY_DATASET=ADD_BQ_DATASET_HERE
GCS_BUCKET_ID=ADD_BUCKET_ID_HERE
SCHEMA_FILE_PATH="ADD_SCHEMA_FILE_PATH_HERE"
SOURCE_BASE_DIR_PATH="ADD_SOURCE_DATA_BASE_DIR_HERE"
```

## dbt Configuration (dbt_project.yml)

The dbt_project.yml file defines key project settings such as:

Project name: dbt_bigquery_project

Version: 1.0.0

Profile name: dbt_bigquery_project

Model storage paths and default materialization type (view for staging models)

## BigQuery Source Definitions (sources.yml)

The sources.yml file defines BigQuery source datasets and tables, including:

categories

customers

departments

order_items

orders

products

Each table has unique constraints and validation rules defined for dbt testing.

## dbt Models

### Dimensional Models

`dim_customer.sql`: Contains customer-related attributes, providing a unified view of customer data.

`dim_department.sql`: Stores department-related information, enabling structured department analysis.

`dim_date.sql`: Contains dates rangin from minimum order date to maximum orderdate.

`dim_product.sql`: Provides detailed product information, ensuring accurate product tracking.

### Fact Table

`fact_sales.sql`: Core fact table capturing transactional sales data, linking to dimensional models for comprehensive reporting.



## Getting Started

### 1️⃣ Install Required Dependencies

Ensure you have dbt and required libraries installed:
```
pip install dbt-bigquery python-dotenv google-cloud-storage google-cloud-bigquery
```

### 2️⃣ Set Up Environment Variables

Create a `.env` file in the project root and add the required variables (or use the provided one).

### 3️⃣ Authenticate with Google Cloud

Make sure you are authenticated with Google Cloud:
```
gcloud auth application-default login
```

### 4️⃣ Upload Data to Google Cloud Storage (GCS)

Run the gcs_load_parquet_files.py script to upload Parquet files from local storage to GCS:
```
python gcs_load_parquet_files.py
```

### 5️⃣ Load Parquet Files into BigQuery

Execute the bq_load_parquet_files_to_table.py script to load Parquet files from GCS into BigQuery tables:
```
python bq_load_parquet_files_to_table.py
```

### 6️⃣ Run dbt Models

Use dbt to transform data in BigQuery:
```
dbt debug  # Verify dbt setup
dbt build  # Run and test dbt models
dbt docs generate  # Generate documentation
dbt docs serve  # Serve documentation locally
```