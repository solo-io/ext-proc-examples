module github.com/solo-io/ext-proc-examples/basic-sink

go 1.23.1

require (
	github.com/envoyproxy/go-control-plane v0.12.1-0.20240621013728-1eb8caab5155
	github.com/solo-io/go-utils v0.27.4-0.20241209192159-5d0eef109b16
	google.golang.org/grpc v1.66.2
)

require (
	github.com/cncf/xds/go v0.0.0-20240423153145-555b57ec207b // indirect
	github.com/envoyproxy/protoc-gen-validate v1.0.4 // indirect
	github.com/golang/protobuf v1.5.4 // indirect
	github.com/k0kubun/pp v3.0.1+incompatible // indirect
	github.com/mattn/go-colorable v0.1.13 // indirect
	github.com/mattn/go-isatty v0.0.19 // indirect
	golang.org/x/net v0.26.0 // indirect
	golang.org/x/sys v0.24.0 // indirect
	golang.org/x/text v0.17.0 // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20240701130421-f6361c86f094 // indirect
	google.golang.org/protobuf v1.34.2 // indirect
)

// Remove once we get to a version with extproc changes in upstream (presumably 1.28)
// the specific go-control-plane-fork-v2 version is found here:
//     https://github.com/solo-io/go-control-plane-fork-v2/compare/release/v1.27-backportedfork/dcf8bfb08a20fbbb4f4dd479d1e2bf6747b9f206
replace github.com/envoyproxy/go-control-plane => github.com/solo-io/go-control-plane-fork-v2 v0.0.0-20231207195634-98d37ef9a43e
