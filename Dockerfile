FROM google/cloud-sdk:latest

# Fix frontend not set error
ARG DEBIAN_FRONTEND=noninteractive

# Install deploy tools
RUN apt-get -y update && apt-get -y install curl git gettext apt-utils

# Set paths
ENV GOROOT /usr/lib/google-cloud-sdk/platform/google_appengine/goroot
ENV GOPATH /usr/lib/google-cloud-sdk/platform/google_appengine/gopath
ENV PATH /usr/lib/google-cloud-sdk/platform/google_appengine:$PATH

# Make gopath directories
RUN mkdir -p $GOPATH/bin
RUN mkdir -p $GOPATH/src
RUN mkdir -p $GOPATH/pkg
RUN chmod -R 777 $GOPATH
ENV PATH $GOPATH/bin:$PATH

# Usinng `goapp` instend of `go`
RUN update-alternatives --install /usr/bin/go goapp /usr/lib/google-cloud-sdk/platform/google_appengine/goapp 10
