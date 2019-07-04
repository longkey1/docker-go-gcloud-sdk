FROM google/cloud-sdk:latest

# Fix frontend not set error
ARG DEBIAN_FRONTEND=noninteractive

# Executable appcfg.py
ENV PATH /usr/lib/google-cloud-sdk/platform/google_appengine:${PATH}
RUN chmod +x /usr/lib/google-cloud-sdk/platform/google_appengine/appcfg.py

# Install packages
RUN apt-get -y update && apt-get -y install apt-utils build-essential curl gettext git wget

# Set Go Version
ENV GO_VERSION 1.12.6

# Set goroot
ENV GOROOT /opt/go
RUN cd /tmp && wget https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz && tar xzvf go${GO_VERSION}.linux-amd64.tar.gz && mv go ${GOROOT}
ENV PATH ${GOROOT}/bin:${PATH}

# Set gopath
ENV GOPATH /work
RUN mkdir -p ${GOPATH}/bin ${GOPATH}/src ${GOPATH}/pkg
RUN chmod -R 777 ${GOPATH}
ENV PATH ${GOPATH}/bin:${PATH}

# Confirm go version
RUN go version

# Install dep
RUN go get -u github.com/golang/dep/cmd/dep

# Install glide
RUN curl https://glide.sh/get | sh
