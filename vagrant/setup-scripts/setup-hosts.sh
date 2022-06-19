#!/bin/bash

cat > /etc/hosts <<EOF
127.0.0.1     localhost
# The following lines are desirable for IPv6 capable hosts
::1   ip6-localhost   ip6-loopback
fe00::0       ip6-localnet
ff00::0       ip6-mcastprefix
ff02::1       ip6-allnodes
ff02::2       ip6-allrouters
ff02::3       ip6-allhosts

#k8 instance entries below

EOF

set -e
IFNAME=$1
ADDRESS="$(ip -4 addr show $IFNAME | grep "inet" | head -1 |awk '{print $2}' | cut -d/ -f1)"

echo "${ADDRESS} ${HOSTNAME} ${HOSTNAME}.local" >> /etc/hosts

export IFS=","
for word in $2; do
  echo $word >> /etc/hosts
done

#cat /etc/hosts
