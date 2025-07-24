#!/bin/bash
echo "Running Trivy vulnerability scan..."
docker build -t demo .
trivy image demo
