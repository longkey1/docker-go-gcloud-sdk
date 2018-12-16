FROM google/cloud-sdk:latest

# Fix frontend not set error
ARG DEBIAN_FRONTEND=noninteractive

# Install deploy tools
RUN apt-get -y update && apt-get -y install curl git gettext apt-utils build-essential

# Set Go Version
ENV GO_VERSION 1.9

# Set paths
ENV GOROOT /usr/lib/google-cloud-sdk/platform/google_appengine/goroot-$GO_VERSION
ENV GOPATH /usr/lib/google-cloud-sdk/platform/google_appengine/gopath
ENV PATH /usr/lib/google-cloud-sdk/platform/google_appengine:$PATH

# Make gopath directories
RUN mkdir -p $GOPATH/bin
RUN mkdir -p $GOPATH/src
RUN mkdir -p $GOPATH/pkg
RUN chmod -R 777 $GOPATH
ENV PATH $GOPATH/bin:$PATH

# Change Permission
RUN chmod +x /usr/lib/google-cloud-sdk/platform/google_appengine/appcfg.py

# Using `goapp` instend of `go`
RUN update-alternatives --install /usr/bin/go go /usr/lib/google-cloud-sdk/platform/google_appengine/goroot-$GO_VERSION/bin/goapp 10

# Confirm go version
RUN go version

# Install dep
RUN go get -u github.com/golang/dep/cmd/dep
