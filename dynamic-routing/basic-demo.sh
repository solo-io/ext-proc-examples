#!/bin/bash

set -e

GLOO_EE_VERSION=1.20.3

# Create a kind cluster:
# kind create cluster --name $CLUSTER

# Install Gateway API CRDs
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.3.0/standard-install.yaml

# Install a recent version of Gloo Gateway Enterprise, with a values file that initializes extproc settings:
helm repo add glooe https://storage.googleapis.com/gloo-ee-helm || true
helm repo update
helm install -n gloo-system gloo-gateway glooe/gloo-ee --create-namespace \
--set-string license_key=$GLOO_LICENSE_KEY \
--version $GLOO_EE_VERSION -f resources/values.yaml

# Apply the Deployment and Service for the extproc service and routing service (note that if you are using a locally-built image, you may need to change the image tag in the below yaml before applying it):
kubectl apply -f resources/routing-service.yaml
kubectl apply -f resources/extproc.yaml

# Deploy target apps
kubectl apply -f resources/foo.yaml
kubectl apply -f resources/bar.yaml

# Create routing config
kubectl create namespace apps-config
kubectl apply -f resources/listener-option.yaml
kubectl apply -f resources/http-listener-option.yaml
kubectl apply -f resources/gateway.yaml
kubectl apply -f resources/httproute.yaml