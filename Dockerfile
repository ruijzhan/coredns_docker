FROM golang:1.18.1 as build
RUN set -x &&\
    git clone https://github.com/coredns/coredns.git &&\
    cd coredns &&\
    go generate coredns.go &&\
    make
FROM alpine:3.15.4
COPY --from=build /go/coredns/coredns /usr/local/bin/coredns
WORKDIR /
HEALTHCHECK CMD wget 127.0.0.1:8080/health -q -O - | grep OK
EXPOSE 53/tcp
EXPOSE 53/udp
EXPOSE 9053
ENTRYPOINT ["coredns"]
