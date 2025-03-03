# gcs_load_parquet_files

import os
import io
import pandas as pd
import pyarrow as pa
import pyarrow.parquet as pq
import re
import glob
import json
from google.cloud import storage
from dotenv import load_dotenv

# Loads variables from .env file
load_dotenv()  

# Create GCS client
gcs_client = storage.Client()
bucket_id = os.environ.get("GCS_BUCKET_ID")
bucket = gcs_client.get_bucket(bucket_id)


def get_column_names(schemas_file, file_name):
    schemas = json.load(open(schemas_file))
    ds_schema = sorted(schemas[file_name], key=lambda col: col['column_position'])
    columns = [col['column_name'] for col in ds_schema]
    return columns

src_base_dir = os.environ.get("SOURCE_BASE_DIR_PATH")

src_sub_dirs = glob.glob(f'{src_base_dir}/*', recursive=True)

src_files = []
for src_sub_dir in src_sub_dirs:
    # normalised_src_sub_dir = os.path.normpath(src_sub_dir)
    if not os.path.isfile(src_sub_dir):
        src_files.append({
            "src_file_path": glob.glob(f'{src_sub_dir}/*', recursive=True)[0],
            "src_file_name": src_sub_dir.split(os.sep)[-1]
        })
        
for src_file in src_files:
    
    schemas_file = os.environ.get("SCHEMA_FILE_PATH")
    file_name = src_file["src_file_name"]
    folder_name = src_file["src_file_name"]
    file_path = src_file["src_file_path"]
    bucket_name = bucket.name

    # Define source CSV and destination in GCS
    destination_parquet_path = f"{folder_name}/{file_name}"  # GCS path
    
    # Define column names
    columns = get_column_names(schemas_file, file_name)
    
    # Read CSV into Pandas DataFrame
    df = pd.read_csv(file_path, names=columns)
    
    # Convert DataFrame to Parquet format in memory (using BytesIO)
    buffer = io.BytesIO()
    table = pa.Table.from_pandas(df)
    pq.write_table(table, buffer, compression='snappy')
    
    # Upload the in-memory Parquet file to GCS with correct content type
    blob = bucket.blob(destination_parquet_path)
    blob.upload_from_string(buffer.getvalue(), content_type="application/parquet")  # Set correct MIME type
    
    print(f"File successfully uploaded to: gs://{bucket_name}/{destination_parquet_path}")