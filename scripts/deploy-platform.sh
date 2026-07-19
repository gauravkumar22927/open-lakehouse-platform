#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

"${ROOT_DIR}/scripts/create-namespaces.sh"

helm repo add minio https://charts.min.io/ >/dev/null
helm repo add bitnami https://charts.bitnami.com/bitnami >/dev/null
helm repo update

helm upgrade --install minio minio/minio \
  --namespace storage \
  --values "${ROOT_DIR}/deploy/helm/minio/values.yaml"

helm upgrade --install postgres bitnami/postgresql \
  --namespace metadata \
  --set auth.username=hive \
  --set auth.password=hivepassword \
  --set auth.database=metastore \
  --set primary.persistence.size=5Gi

kubectl apply -f "${ROOT_DIR}/deploy/kubernetes/hive-metastore"
kubectl apply -f "${ROOT_DIR}/deploy/kubernetes/spark"
kubectl apply -f "${ROOT_DIR}/deploy/kubernetes/jupyter"

kubectl rollout status deployment/hive-metastore -n metadata --timeout=180s
kubectl rollout status deployment/spark -n metadata --timeout=180s
kubectl rollout status deployment/jupyter -n compute --timeout=180s
