#!/bin/bash
echo "Deploying to Kubernetes..."
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
