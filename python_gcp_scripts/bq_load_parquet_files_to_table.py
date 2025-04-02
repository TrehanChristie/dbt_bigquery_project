# bq_load_parquet_files_to_table

import json
import os
from google.cloud import storage
from google.cloud import bigquery
from dotenv import load_dotenv

# Loads variables from .env file
load_dotenv()  

# Create BigQuery client
bq_client = bigquery.Client()
project_id = os.environ.get("PROJECT_ID")
dataset_id = os.environ.get("BIGQUERY_DATASET")

# Create GCS client
gcs_client = storage.Client()
bucket_id = os.environ.get("GCS_BUCKET_ID")
bucket = gcs_client.get_bucket(bucket_id)

def delete_table_if_exists(table_id):
    """Deletes a BigQuery table if it exists."""
    try:
        bq_client.get_table(table_id)  # Check if the table exists
        print(f"Table {table_id} exists. Deleting...")
        bq_client.delete_table(table_id)  # Delete the table
        print(f"Table {table_id} deleted successfully.")
    except Exception as e:
        if "Not found" in str(e):
            print(f"Table {table_id} does not exist. Proceeding with load.")
        else:
            print(f"Error while checking/deleting table: {e}")
            raise  # Raise the error if it's not a "not found" case

# List all files (objects) in the bucket
blobs = bucket.list_blobs()

for blob in blobs:

    # extract blob uri, name and set bq table name
    blob_uri = f"gs://{bucket_id}/{blob.name}"
    blob_name = blob_uri.split('/')[-1]
    bq_table_name = blob_name

    # extract schema for current blob
    schema_format = get_schema(schemas_file, blob_name)
    
    print(f"blob_path: {blob_uri}")
    print(f"blob_name: {blob_name}")

    # set table id for BQ
    table_id = f"{project_id}.{dataset_id}.{bq_table_name}"

    # Delete table if it exists before loading new data
    delete_table_if_exists(table_id)    
    
    # confiqure a load job in BQ
    blob_job_config = bigquery.LoadJobConfig(
        source_format=bigquery.SourceFormat.PARQUET,
        # schema=schema_format,
        autodetect=True
    )
    
    # Make an API request
    load_job = bq_client.load_table_from_uri(
        blob_uri, table_id, job_config=blob_job_config
    )  
    
    load_job.result()   
