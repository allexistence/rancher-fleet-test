#!/usr/bin/env bash
# 1) Delete the GitRepo -> Fleet uninstalls everything it deployed (needs the SA, so RBAC goes last).
# 2) Remove the service account, RBAC and the fleet-poc namespace.
kubectl delete gitrepo fleet-poc -n fleet-local --ignore-not-found
kubectl delete secret git-auth -n fleet-local --ignore-not-found
echo "Waiting for Fleet to remove the workloads..."; sleep 30
kubectl get all -n fleet-poc
kubectl delete -f "$(dirname "$0")/../fleet/rbac-local.yaml" --ignore-not-found
kubectl label clusters.fleet.cattle.io local -n fleet-local env- 2>/dev/null
echo "Done."
