FROM alpine:latest AS builder

RUN apk update && apk add --no-cache git gcc g++ cmake make wget tar

RUN git clone --recurse-submodules -b v1.64.1 https://github.com/grpc/grpc && \
    cd grpc && \
    mkdir -p cmake/build && \
    cd cmake/build && \
    cmake ../.. && \
    make grpc_php_plugin && \
    cp grpc_php_plugin /usr/local/bin/

RUN wget -q -O protoc-gen-php-grpc.tar.gz https://github.com/roadrunner-server/roadrunner/releases/download/v2024.1.2/protoc-gen-php-grpc-2024.1.2-linux-amd64.tar.gz && \
    mkdir -p /usr/local/bin/protoc-gen-php-grpc && \
    tar -xzf protoc-gen-php-grpc.tar.gz -C /usr/local/bin --strip-components=1 && \
    chmod +x /usr/local/bin/protoc-gen-php-grpc && \
    rm -f protoc-gen-php-grpc.tar.gz

FROM alpine:latest

LABEL maintainer="work.koregin@gmail.com"
LABEL version="1.0.0"

COPY --from=builder /usr/local/bin/grpc_php_plugin /usr/local/bin/
COPY --from=builder /usr/local/bin/protoc-gen-php-grpc /usr/local/bin/

ENTRYPOINT ["protoc"]
