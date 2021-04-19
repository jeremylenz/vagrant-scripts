#!/bin/bash
# Run this on the hypervisor after the VM's IP address changes.
# It will update your /etc/hosts to the new IP address

cd /home/jeremylenz/code/forklift
VAGRANT_BOX=$1
if [ -z $VAGRANT_BOX ] # if no command-line arg provided, use centos7-katello-devel
then
  VAGRANT_BOX="centos7-katello-devel"
fi
echo VAGRANT_BOX: $VAGRANT_BOX
echo "Getting devel box IP..."
DEVEL_BOX_IP=$(vagrant ssh-config $VAGRANT_BOX | grep -Po 'HostName \K[\d.]+')
cd /home/jeremylenz/code
echo DEVEL_BOX_IP: $DEVEL_BOX_IP

if [ -z $DEVEL_BOX_IP ]
then
  echo "Couldn't get the box IP address; exiting :("
  exit 1
fi

echo "./update-etc-hosts.rb ${DEVEL_BOX_IP $VAGRANT_BOX}"
sudo ./update-etc-hosts.rb $DEVEL_BOX_IP $VAGRANT_BOX
