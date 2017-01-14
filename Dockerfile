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

RUN mkdir /go
ENV GOPATH /go
ENV PATH $PATH:/usr/local/go_appengine
RUN ln -s /user/local/go_appengine/goroot/bin/goapp /user/local/bin/go

ENV CLOUDSDK_PYTHON_SITEPACKAGES 1

# Install the GO
#
#ENV GO_VER 1.6.2
#ENV GO_GZ go$GO_VER.linux-amd64.tar.gz
#
#ADD https://storage.googleapis.com/golang/$GO_GZ .
#RUN tar -C /usr/local -xzf $GO_GZ && rm -f $GO_GZ
#ENV PATH $PATH:/usr/local/go/bin:/go/bin
