# Get the currently used golang install path (in GOPATH/bin, unless GOBIN is set)
ifeq (,$(shell go env GOBIN))
GOBIN=$(shell go env GOPATH)/bin
else
GOBIN=$(shell go env GOBIN)
endif

TESTDATA_DIR="testdata"

.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: test

# Run tests
test: fmt vet ## smoke test all generated go files
	go test ./... -coverprofile cover.out

grpc-install: ## command to install grpc generator in linux. Note: you will need to include ${HOME}/protoc/bin in your path manually
	go get -u google.golang.org/grpc
	go get -u github.com/golang/protobuf/protoc-gen-go
	mkdir -p ${HOME}/protoc
	cd ${HOME}/protoc && \
	rm -rf * && \
	wget https://github.com/protocolbuffers/protobuf/releases/download/v3.15.6/protoc-3.15.6-linux-x86_64.zip && \
	unzip protoc-3.15.6-linux-x86_64.zip 

grpc-gen: ## generate go package based on pb files. Note: all new pb folers must be added in this command.
	protoc --proto_path=pb --go_out=plugins=grpc:${TESTDATA_DIR} ${TESTDATA_DIR}/*.proto
	
# Run go fmt against code
fmt: ## formating go codes
	go fmt ./...

# Run go vet against code
vet:
	go vet ./...
