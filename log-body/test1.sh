#!/bin/bash

curl -v localhost:8080/post -H"Host: extproc.example.com" -X POST -d '{"payload": "my-small-payload"}' -H"Content-Type: application/json"