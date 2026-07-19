#!/usr/bin/env bash
set -euo pipefail

kubectl exec -n storage deployment/minio -- sh -c \
  'mc alias set local http://localhost:9000 "$MINIO_ROOT_USER" "$MINIO_ROOT_PASSWORD" >/dev/null && mc mb --ignore-existing local/lakehouse'

kubectl exec -n metadata deployment/spark -- /opt/spark/bin/spark-sql -e "
CREATE DATABASE IF NOT EXISTS lakehouse LOCATION 's3a://lakehouse/warehouse';
USE lakehouse;
DROP TABLE IF EXISTS smoke_delta;
CREATE TABLE smoke_delta (id INT, name STRING) USING delta;
INSERT INTO smoke_delta VALUES (1, 'bronze'), (2, 'silver');
SELECT * FROM smoke_delta ORDER BY id;
"
