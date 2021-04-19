#!/bin/bash

FQDN=$(hostname)
echo hostname: $FQDN

DEVEL_BOX_IP=$(ip addr | grep "eth0" | grep -Po 'inet \K[\d.]+')
echo DEVEL_BOX_IP: $DEVEL_BOX_IP

if [ -z $FQDN ]
then
  echo "Couldn't get the hostname; exiting :("
  exit 1
fi

if [ -z $DEVEL_BOX_IP ]
then
  echo "Couldn't get the IP address; exiting :("
  exit 1
fi

echo "./update-etc-hosts.rb ${DEVEL_BOX_IP $FQDN}"
sudo ./update-etc-hosts.rb $DEVEL_BOX_IP $FQDN
