#!/usr/bin/env bash
# Usage: ./scripts/verify.sh [fleet-local|fleet-default]
NS=${1:-fleet-local}
echo "== GitRepo =="; kubectl get gitrepo -n "$NS" -o wide
echo; echo "== Bundles =="; kubectl get bundles -n "$NS"
echo; echo "== BundleDeployments (per cluster) =="; kubectl get bundledeployments -A
echo; echo "== Clusters & labels =="; kubectl get clusters.fleet.cattle.io -n "$NS" --show-labels
echo; echo "== Workloads (run against the target cluster) =="
for n in fleet-poc fleet-poc-raw fleet-poc-helm fleet-poc-kustomize; do
  echo "-- $n"; kubectl get deploy,svc,pods -n "$n" 2>/dev/null || echo "   (not on this cluster)"
done
