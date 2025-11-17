#!/bin/bash

curl -v localhost:8080/post -H"Host: extproc.example.com" -X POST -T "10m-payload.txt" -H"Content-Type: application/json"