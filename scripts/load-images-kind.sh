#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="${CLUSTER_NAME:-lakehouse-cluster}"

kind load docker-image lakehouse/hive-metastore:1.0 --name "${CLUSTER_NAME}"
kind load docker-image lakehouse/spark:1.0 --name "${CLUSTER_NAME}"
kind load docker-image lakehouse/jupyter:1.0 --name "${CLUSTER_NAME}"
