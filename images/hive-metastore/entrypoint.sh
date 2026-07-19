#!/bin/bash
set -e

echo "Checking Hive Metastore schema..."

if schematool \
  -dbType postgres \
  -info; then
  echo "Hive Metastore schema already exists."
else
  echo "Initializing Hive Metastore schema..."
  schematool \
    -dbType postgres \
    -initSchema
fi

echo "Starting Hive Metastore..."

exec hive --service metastore
