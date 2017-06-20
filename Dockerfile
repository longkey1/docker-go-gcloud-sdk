FROM google/cloud-sdk:latest

RUN gcloud components install app-engine-go

ENV GOROOT /google-cloud-sdk/platform/google_appengine/goroot
ENV GOPATH /google-cloud-sdk/platform/google_appengine/gopath
ENV PATH /google-cloud-sdk/platform/google_appengine:$PATH

RUN ln -s /google-cloud-sdk/platform/google_appengine/goroot/bin/goapp /google-cloud-sdk/platform/google_appengine/go

RUN mkdir -p $GOPATH/bin
RUN mkdir -p $GOPATH/src
RUN mkdir -p $GOPATH/pkg
RUN chmod -R 777 $GOPATH
ENV PATH $GOPATH/bin:$PATH

# Install deploy tools
RUN apk --no-cache add git gettext
