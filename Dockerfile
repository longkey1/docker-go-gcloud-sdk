FROM google/cloud-sdk:latest

RUN apt-get -y update && apt-get -y install curl

ENV GOROOT /go_appengine/goroot
ENV GOPATH /go_appengine/gopath
RUN update-alternatives --install /usr/bin/go goapp /go_appengine/goroot/bin/goapp 10
ENV PATH /go_appengine:$PATH

RUN mkdir -p $GOPATH/bin
RUN mkdir -p $GOPATH/src
RUN mkdir -p $GOPATH/pkg
RUN chmod -R 777 $GOPATH
ENV PATH $GOPATH/bin:$PATH
