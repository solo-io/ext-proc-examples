# basic-sink

## Usage

This is an example external processing service that takes instructions in a request or response header
named `instructions`. The value of the `instructions` header must be a JSON string in the format:
```
{
  "addHeaders": {
    "header1": "value1",
    "header2": "value2"
  },
  "removeHeaders": [ "header3", "header4" ],
  "setBody": "this is the new body",
  "setTrailers": {
    "trailer1": "value1",
    "trailer2": "value2"
  }
}
```
All fields are optional. See the `Instructions` struct in [main.go](./main.go) for details on the meaning of each field.

Note that these instructions need to come as part of the `Headers` field of a `RequestHeaders` or `ResponseHeaders`
[ProcessingRequest](https://www.envoyproxy.io/docs/envoy/latest/api-v3/service/ext_proc/v3/external_processor.proto#service-ext-proc-v3-processingrequest). Therefore, the instructions will only be received/processed if the
request or response header processing mode is set to `SEND` (or `DEFAULT` since the default for headers is `SEND`).

*Modifying the body or trailers has not been tested and may not work as expected.*

## Updating

The basic-sink service is currently published as image `gcr.io/solo-test-236622/ext-proc-example-basic-sink:<TAG>`
and used in Gloo Edge e2e tests.

To make changes to the service:
1. Update the `TAG` in the Makefile to a new version.
1. Run `make all docker-push`, which will compile and publish a new version of the image to gcr.io. *Make sure you update the TAG before running this, so you don't overwrite an existing tag that is being used in e2e tests!*
1. Update e2e tests to use the new tag.

## Example Configuration in Gloo Edge

The [resources](./resources) folder contains example configuration for setting up Gloo Edge
to use the external processing service. Here are steps for a simple setup:

Create a kind cluster:
```
kind create cluster --name test --image "kindest/node:v1.27.3"
```
Install a recent version of Gloo Edge, with a values file that initializes extproc settings:
```
helm install -n gloo-system gloo-ee gloo-ee/gloo-ee --create-namespace --set-string license_key=$GLOO_LICENSE_KEY --set gloo-fed.enabled=false --version v1.15.2 -f resources/values.yaml
```
Apply the Deployment and Service for the extproc service:
```
kubectl apply -f resources/extproc.yaml
```
Create a VirtualService that routes to httpbin:
```
kubectl apply -f resources/httpbin.yaml
kubectl apply -f resources/vs.yaml
```

Send traffic through the VS, with extproc instructions in the header:
```
kubectl port-forward -n gloo-system deploy/gateway-proxy 8080&

curl -v localhost:8080/get -H "header1: value1" -H "header2: value2" -H 'instructions: {"addHeaders":{"header3":"value3","header4":"value4"},"removeHeaders":["instructions", "header2"]}'
```
This should result in a response showing headers similar to the following (`header3` and `header4` were added; `header2` and `instructions` were removed):
```
  "headers": {
    ...
    "Header1": "value1",
    "Header3": "value3",
    "Header4": "value4",
    ...
  }
```
