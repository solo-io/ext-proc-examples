#!/bin/bash

set -e

CLUSTER=test
GLOO_EE_VERSION=v1.17.0

# Create a kind cluster:
kind create cluster --name $CLUSTER

# Install Gateway API CRDs
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.0.0/standard-install.yaml

# Install a recent version of Gloo Gateway, with a values file that initializes extproc settings:
helm install -n gloo-system gloo-gateway glooe/gloo-ee --create-namespace --set-string license_key=$GLOO_LICENSE_KEY --set gloo-fed.enabled=false --version $GLOO_EE_VERSION -f resources/values.yaml

# Apply the Deployment and Service for the extproc service (note that if you are using a locally-built image, you may need to change the image tag in the below yaml before applying it):
kubectl apply -f resources/extproc.yaml

# Create an HTTP gateway
kubectl apply -f resources/gateway.yaml

# Create an HTTPRoute that routes to httpbin:
kubectl apply -f resources/httpbin.yaml
kubectl apply -f resources/httproute.yaml
