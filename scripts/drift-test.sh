#!/usr/bin/env bash
# Manually change a Fleet-managed Deployment and watch Fleet put it back.
set -e
NS=${1:-fleet-poc}   # pass fleet-poc-raw if targetNamespace is not used
echo "Scaling web to 5 replicas manually (Git says 2)..."
kubectl scale deploy/web -n "$NS" --replicas=5
for i in $(seq 1 12); do
  sleep 10
  echo "$(date +%T) replicas=$(kubectl get deploy web -n "$NS" -o jsonpath='{.spec.replicas}')"
done
echo "If correctDrift is on, replicas should be back to 2."
