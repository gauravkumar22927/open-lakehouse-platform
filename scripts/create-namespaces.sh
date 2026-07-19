#!/usr/bin/env bash
set -euo pipefail

for namespace in storage metadata compute analytics monitoring; do
  kubectl create namespace "${namespace}" --dry-run=client -o yaml | kubectl apply -f -
done
