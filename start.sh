#!/bin/bash
IP=$(hostname -I | awk '{print $1}')
docker rm -fv coredns
docker run -d --name coredns \
           -m 256m \
           --log-opt max-size=16m \
           --restart=always \
           -v /etc/localtime:/etc/localtime \
           -v $(pwd)/hosts:/etc/hosts \
           -v $(pwd)/Corefile:/Corefile \
           -p $IP:53:53/tcp \
     	   -p $IP:53:53/udp \
           -p 9053:9053/tcp \
           ruijzhan/coredns:$ARCH

