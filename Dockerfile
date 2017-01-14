FROM debian:latest

RUN apt-get -y update && apt-get -y install curl git wget build-essential lsb-release unzip python-openssl

# Install the Google Cloud SDK.

RUN echo "deb http://packages.cloud.google.com/apt cloud-sdk-$(lsb_release -c -s) main" | tee /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN apt-get -y update && apt-get -y install google-cloud-sdk

# Install the Google AppEngine SDK for GO

ENV GAE_SDK_GO_VER 1.9.48
ENV GAE_SDK_GO_ZIP go_appengine_sdk_linux_amd64-$GAE_SDK_GO_VER.zip

ADD https://storage.googleapis.com/appengine-sdks/featured/$GAE_SDK_GO_ZIP .
RUN unzip -q $GAE_SDK_GO_ZIP -d /usr/local && rm -f $GAE_SDK_GO_ZIP
ENV GOROOT /usr/local/go_appengine/goroot
ENV GOPATH /usr/local/go_appengine/gopath

RUN ln -s /usr/local/go_appengine/goroot/bin/goapp /usr/local/bin/go
ENV PATH /usr/local/go_appengine:$PATH

RUN mkdir -p $GOPATH/bin
RUN mkdir -p $GOPATH/src
RUN mkdir -p $GOPATH/pkg
RUN chmod -R 777 $GOPATH
ENV PATH $GOPATH/bin:$PATH

ENV CLOUDSDK_PYTHON_SITEPACKAGES 1
