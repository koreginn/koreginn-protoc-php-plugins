# PHP-GRPC-Tools

## Install

```dockerfile
FROM koreginn/php-grpc-tools:1.0.0 AS grpc-tools

FROM php:8.3-alpine AS build

COPY --from=grpc-tools /usr/local/bin/grpc_php_plugin /usr/local/bin/
COPY --from=grpc-tools /usr/local/bin/protoc-gen-php-grpc /usr/local/bin/
```

## Usage
```shell
protoc --proto_path=examples/protos \
  --php_out=examples/php/route_guide \
  --grpc_out=examples/php/route_guide \
  --plugin=protoc-gen-grpc=/usr/local/bin/grpc_php_plugin \
  ./examples/protos/route_guide.proto
```
