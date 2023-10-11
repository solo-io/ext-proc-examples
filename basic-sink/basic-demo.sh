#!/bin/bash

set -e

CLUSTER=test
GLOO_EE_VERSION=v1.15.2

# Create a kind cluster:
kind create cluster --name $CLUSTER

# Install a recent version of Gloo Edge, with a values file that initializes extproc settings:
helm install -n gloo-system gloo-ee gloo-ee/gloo-ee --create-namespace --set-string license_key=$GLOO_LICENSE_KEY --set gloo-fed.enabled=false --version $GLOO_EE_VERSION -f resources/values.yaml

# Apply the Deployment and Service for the extproc service (note that if you are using a locally-built image, you may need to change the image tag in the below yaml before applying it):
kubectl apply -f resources/extproc.yaml

# Create a VirtualService that routes to httpbin:
kubectl apply -f resources/httpbin.yaml
kubectl apply -f resources/vs.yaml
