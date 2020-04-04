#!/bin/bash
printf "        except "
curl https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/accelerated-domains.china.conf -s |  while read line; do awk -F '/' '{print $2}' | grep -v '#' ; done |  paste -sd " " -
