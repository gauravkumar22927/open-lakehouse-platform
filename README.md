# Open Lakehouse Platform

Production-style local lakehouse on Kind Kubernetes using open-source components:
Spark 4.0.1, Delta Lake, Hive Metastore 4.0.1, PostgreSQL, MinIO, and Jupyter.

## Quick Start

```bash
kind create cluster --config deploy/kind/cluster.yaml
./scripts/build-images.sh
./scripts/load-images-kind.sh
./scripts/deploy-platform.sh
./scripts/smoke-test.sh
```

Expected smoke-test result:

```text
1    bronze
2    silver
```

## Layout

```text
deploy/
  kind/                  Kind cluster definition
  helm/                  Helm values
  kubernetes/            Kubernetes manifests

images/
  hive-metastore/        Custom Hive Metastore image
  spark/                 Custom Spark image and Spark config
  jupyter/               Custom Jupyter image

scripts/
  build-images.sh
  load-images-kind.sh
  deploy-platform.sh
  smoke-test.sh

docs/
  learning/create_cluster.txt
```

## Documentation

Read the full runbook:

```bash
less docs/learning/create_cluster.txt
```

## Useful Commands

```bash
kubectl get pods -A
kubectl logs -n metadata deployment/hive-metastore --tail=100
kubectl exec -it -n metadata deployment/spark -- /opt/spark/bin/spark-sql
kubectl port-forward -n compute deployment/jupyter 8888:8888
kubectl port-forward -n storage svc/minio-console 9001:9001
```

MinIO console:

```text
http://localhost:9001
user: admin
password: admin12345
```
