# Basic Body Logging Example

## Usage

This is an example external processing service that will log request and response bodies.  

## Compatibility

This sample app has been tested to work with Gloo Gateway 1.20.x but may  work with older versions of Gloo Gateway.

## Building and Testing Locally

To build and use the service locally:
1. Create a local cluster using kind or docker-desktop.
2. Compile the extproc server using `make server` and `make docker-local`.
3. Deploy the solution into your local cluster using the `basic-demo.sh` script.

You can use the `test1.sh` and `test2.sh` scripts to send data into the server and inspect the logs.

## References

This code was originally based on the sample server from https://github.com/salrashid123/envoy_ext_proc