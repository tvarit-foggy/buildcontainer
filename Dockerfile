FROM python:3.6-stretch

ENV GOROOT=/usr/local
ENV GOPATH=/go
ENV PATH=/go/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN apt-get update && apt-get install -qq -y --no-install-recommends default-libmysqlclient-dev git curl build-essential xz-utils && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/local

RUN mkdir node && \
    curl -LO --compressed "https://nodejs.org/dist/v10.16.0/node-v10.16.0-linux-x64.tar.xz" && \
    tar -xJf "node-v10.16.0-linux-x64.tar.xz" -C node --strip-components=1 --no-same-owner && \
    rm -f "node-v10.16.0-linux-x64.tar.xz"

RUN curl -LO --compressed "https://dl.google.com/go/go1.11.linux-amd64.tar.gz" && \
    tar -xf "go1.11.linux-amd64.tar.gz" && \
    rm -f "go1.11.linux-amd64.tar.gz"

RUN mkdir yarn && \
    curl -LO --compressed "https://yarnpkg.com/downloads/1.16.0/yarn-v1.16.0.tar.gz" && \
    tar -xJf "yarn-v1.16.0.tar.gz" -C node --strip-components=1 --no-same-owner && \
    rm -f "yarn-v1.16.0.tar.gz"

COPY requirements.txt /
RUN pip install -r /requirements.txt

RUN mkdir -p /go/src/github.com/grafana/grafana
RUN ln -sd /go/src/github.com/grafana/grafana /grafana

WORKDIR /go/src/github.com/grafana/grafana

RUN go get -v github.com/Unknwon/bra
RUN go get -v github.com/golang/dep
RUN go install github.com/golang/dep/cmd/dep

ENTRYPOINT [ "/bin/bash" ]

