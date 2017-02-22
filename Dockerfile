FROM google/cloud-sdk:latest

RUN apt-get -y update && apt-get -y install curl

ENV GOROOT /google-cloud-sdk/platform/google_appengine/goroot
ENV GOPATH /google-cloud-sdk/platform/google_appengine/gopath
ENV PATH /google-cloud-sdk/platform/google_appengine:$PATH

RUN mkdir -p $GOPATH/bin
RUN mkdir -p $GOPATH/src
RUN mkdir -p $GOPATH/pkg
RUN chmod -R 777 $GOPATH
ENV PATH $GOPATH/bin:$PATH

RUN update-alternatives --install /usr/bin/go goapp /google-cloud-sdk/platform/google_appengine/goroot/bin/goapp 10
