FROM debian:buster-slim

ENV JSONNET_VERSION=0.15.0 \
    JSONNET_SHA1=065d517379fa4d1137d8ce7993afcc8f986bdac2

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