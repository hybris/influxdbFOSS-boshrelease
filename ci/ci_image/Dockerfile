#
# Ubuntu 16.04 LTS based Dockerfile
#
# Pull base image.
FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
    curl \
    wget \
    bzr \
    git \
    ruby \
    ruby-dev

# Install BOSH CLI
RUN apt-get install -y build-essential libxml2-dev libsqlite3-dev libxslt1-dev libpq-dev libmysqlclient-dev zlib1g-dev && \
    gem install bosh_cli --no-ri --no-rdoc

# Install Spruce
ADD https://github.com/geofffranks/spruce/releases/download/v1.8.0/spruce-linux-amd64 /usr/local/bin/spruce
RUN chmod +x /usr/local/bin/spruce

# Install Go
ENV GOROOT /goroot
ENV GOPATH /gopath
RUN mkdir -p "$GOROOT" "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH" && \
    curl https://storage.googleapis.com/golang/go1.6.linux-amd64.tar.gz | tar xvzf - -C "$GOROOT" --strip-components=1
    #&& \
    #rm go1.6.linux-amd64.tar.gz
ENV PATH $GOROOT/bin:$GOPATH/bin:$PATH
WORKDIR $GOPATH

# Install yaml2json
RUN go get github.com/bronze1man/yaml2json

# Install Vault
ENV VAULT_VERSION 0.6.2
RUN wget -qO /tmp/vault.zip https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip && \
      unzip -d /bin /tmp/vault.zip && rm /tmp/vault.zip && chmod 755 /bin/vault
