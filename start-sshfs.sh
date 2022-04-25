#!/usr/bin/env bash
# Get the IP address of a Vagrant box using vagrant ssh-config, then connect to it using sshfs.

cd /home/jeremylenz/code/forklift
VAGRANT_BOX=$1
if [ -z $VAGRANT_BOX ] # if no command-line arg provided, use centos7-katello-devel
then
  VAGRANT_BOX="centos8-katello-devel"
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

echo mkdir -p /home/jeremylenz/code/$VAGRANT_BOX
mkdir -p /home/jeremylenz/code/$VAGRANT_BOX

echo "Connecting via sshfs..."
echo "sshfs vagrant@$DEVEL_BOX_IP:/home/vagrant/ /home/jeremylenz/code/$VAGRANT_BOX/ -o IdentityFile=/home/jeremylenz/code/forklift/.vagrant/machines/$VAGRANT_BOX/libvirt/private_key"
sshfs vagrant@$DEVEL_BOX_IP:/home/vagrant/ /home/jeremylenz/code/$VAGRANT_BOX/ -o IdentityFile=/home/jeremylenz/code/forklift/.vagrant/machines/$VAGRANT_BOX/libvirt/private_key

if [ $? -eq 0 ]
then
  echo "done!"
  cd /home/jeremylenz/code/$VAGRANT_BOX
fi
