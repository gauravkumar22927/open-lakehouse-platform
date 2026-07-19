#!/usr/bin/env bash
set -euo pipefail

kubectl rollout restart deployment/hive-metastore -n metadata
kubectl rollout restart deployment/spark -n metadata
kubectl rollout restart deployment/jupyter -n compute

kubectl rollout status deployment/hive-metastore -n metadata --timeout=180s
kubectl rollout status deployment/spark -n metadata --timeout=180s
kubectl rollout status deployment/jupyter -n compute --timeout=180s
