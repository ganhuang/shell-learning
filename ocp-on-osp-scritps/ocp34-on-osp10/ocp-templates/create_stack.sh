#!/bin/bash
set -e
if [ $# != 1 ];then
  echo "Usage: $0 /path/to/template_file"
  exit 1
fi

source /home/nay/ghuang/qe-openrc-v3.sh

stack_name=$(echo "$1" | awk -F"/" '{print $NF}' | cut -d . -f 1) 

if [ -n "$(openstack stack list | grep $stack_name)" ];then

while true;do
  read -p "Do you wish to delete stack $stack_name? [y/n]-" yn
  case $yn in
        [Yy]* ) openstack stack delete $stack_name; break;;
        [Nn]* ) break;; 
        * ) break;;
  esac
done

else

  set -x
  #openstack stack create $stack_name -t 1200 -e $1  -f /usr/share/openshift-heat-templates/openshift.yaml 
  openstack stack create --timeout 1200 -e $1  -t /usr/share/openshift-heat-templates/openshift.yaml $stack_name 
  set +x

fi


echo "sleep 5 seconds..."
sleep 5


time=1
while true;
do
  stack_output=$(openstack stack list | grep $stack_name)
  if echo $stack_output |grep -q -i -v "create_in_progress" ;then
     if echo $stack_output | grep -q -i "create_complete";then
       set -x
       router_ip=$(openstack stack output show ha-master-dedicated-flannel router_ip |grep "output_value" | awk -F"|" '{printf $3}' | sed -e 's/ //g')
       openstack stack output show $stack_name api_url
       openstack stack output show $stack_name console_url
       openstack stack output show $stack_name loadbalancer_ip
       set +x
       echo "Updating A records for app"
       if [ ! -z $router_ip ];then
         sh nsupdate.sh $(echo $router_ip | tr -d '"')
         echo "A records updated"
       fi
     fi
     echo "$stack_output"
     exit 1
  fi
  echo "stack $stack_name is in progress, sleep $[time*5] seconds..."
  sleep 5
  time=`expr $time + 1`
done






