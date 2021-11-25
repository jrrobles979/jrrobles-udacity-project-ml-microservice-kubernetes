#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
# dockerpath=<>
dockerpath=jrrobles/mlrsbostonprices

# Step 2
# Run the Docker Hub container with kubernetes
minikube kubectl -- create deployment ml-rs-boston-prices --image=docker.io/jrrobles/mlrsbostonprices

# Step 3:
# List kubernetes pods
minikube kubectl -- get pods

# Step 4:
# Forward the container port to a host
export POD_NAME=$(minikube kubectl -- get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
echo POD_NAME: $POD_NAME
minikube kubectl -- expose deployment/ml-rs-boston-prices --type="NodePort" --port 8000
minikube kubectl -- port-forward pod/$POD_NAME 8000:80