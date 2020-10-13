FROM debian:buster-slim

ENV JSONNET_VERSION=0.16.0 \
    JSONNET_SHA1=2791229ccd3a0f867a04223b533cb0157d72aa14

RUN apt-get update && \
    apt-get -y install --no-install-recommends curl git bash && \
    curl -Lk "https://github.com/google/jsonnet/releases/download/v${JSONNET_VERSION}/jsonnet-bin-v${JSONNET_VERSION}-linux.tar.gz" -o jsonnet.tgz && \
    echo "${JSONNET_SHA1}  jsonnet.tgz" | sha1sum -c - && \
    tar xzvf jsonnet.tgz && \
    mv jsonnet /usr/bin/jsonnet && \
    mv jsonnetfmt /usr/bin/jsonnetfmt && \
    rm jsonnet.tgz && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
