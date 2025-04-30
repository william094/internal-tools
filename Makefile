mock:
	@rm -rf mocks/*.go
	@mockery --all --dir=./rpc
proto:
	@protoc --go_out=. --go-grpc_out=. --proto_path=${GOPATH}/src --proto_path=. --experimental_allow_proto3_optional  rpc/*.proto
	@protoc-go-inject-tag -input="./rpc/*.pb.go"
	@protofmt -w rpc/*.proto

base:
	protoc ./rpc/base.proto --proto_path=. --go_out=. --go-grpc_out=. 
gproto:
	@goctl rpc protoc ./rpc/usersv.proto --style=go_zero  --proto_path=. --go_out=.  --zrpc_out=. --go-grpc_out=.  -m 
	@protoc-go-inject-tag -input="./rpc/*.pb.go"
	@protofmt -w rpc/*.proto
	@mv ./internal/server server
	@rm -rf internal etc *.go
desc:
	protoc --descriptor_set_out=./descriptor/usersv.pb  ./rpc/usersv.proto ./rpc/base.proto 
