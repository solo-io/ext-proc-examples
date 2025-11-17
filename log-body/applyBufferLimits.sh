#!/bin/bash

kubectl apply -f -<<EOF
apiVersion: gateway.solo.io/v1
kind: ListenerOption
metadata:
  name: bufferlimits
  namespace: gloo-system
spec:
  targetRefs:
  - group: gateway.networking.k8s.io
    kind: Gateway
    name: http
  options:
    perConnectionBufferLimitBytes: 10485760
EOF