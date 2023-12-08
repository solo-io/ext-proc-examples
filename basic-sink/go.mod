module github.com/solo-io/ext-proc-examples/basic-sink

go 1.20

require (
	github.com/envoyproxy/go-control-plane v0.11.1
	github.com/solo-io/go-utils v0.24.6
	google.golang.org/grpc v1.58.1
)

require (
	github.com/cncf/xds/go v0.0.0-20230607035331-e9ce68804cb4 // indirect
	github.com/envoyproxy/protoc-gen-validate v1.0.2 // indirect
	github.com/golang/protobuf v1.5.3 // indirect
	github.com/k0kubun/pp v3.0.1+incompatible // indirect
	github.com/mattn/go-colorable v0.1.13 // indirect
	github.com/mattn/go-isatty v0.0.19 // indirect
	golang.org/x/net v0.15.0 // indirect
	golang.org/x/sys v0.12.0 // indirect
	golang.org/x/text v0.13.0 // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20230913181813-007df8e322eb // indirect
	google.golang.org/protobuf v1.31.0 // indirect
)

// Remove once we get to a version with extproc changes in upstream (presumably 1.28)
// the specific go-control-plane-fork-v2 version is found here:
//     https://github.com/solo-io/go-control-plane-fork-v2/compare/release/v1.27-backportedfork/dcf8bfb08a20fbbb4f4dd479d1e2bf6747b9f206
replace github.com/envoyproxy/go-control-plane => github.com/solo-io/go-control-plane-fork-v2 v0.0.0-20231207195634-98d37ef9a43e
