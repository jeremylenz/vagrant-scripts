cd /home/jeremylenz/code/forklift
VAGRANT_BOX=$1
if [ -z $VAGRANT_BOX ] # if no command-line arg provided, use centos7-katello-devel
then
  VAGRANT_BOX="centos7-katello-devel"
fi
echo VAGRANT_BOX: $VAGRANT_BOX
vagrant ssh $VAGRANT_BOX
