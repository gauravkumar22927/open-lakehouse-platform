#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

docker build -t lakehouse/hive-metastore:1.0 "${ROOT_DIR}/images/hive-metastore"
docker build -t lakehouse/spark:1.0 "${ROOT_DIR}/images/spark"
docker build -t lakehouse/jupyter:1.0 "${ROOT_DIR}/images/jupyter"
