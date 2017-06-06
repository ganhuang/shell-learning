#!/bin/bash

set -e
if [ $# -ne 1 ]; then 
    echo "Usage: $(basename $0) /path/to/template_file" 
    exit 1
fi

stack_name=$(echo "$1" | awk -F"/" '{print $NF}' | cut -d . -f 1)
openstack stack show $stack_name

if [ $? != 0 ];then
   echo "Not found the stack!"
   exit 1
fi

if echo $(openstack stack show $stack_name) |grep -q DELETE_IN_PROGRESS;then
   openstack stack delete $stack_name
   sleep 10
fi

# https://github.com/redhat-openstack/openshift-on-openstack/blob/master/README_bugs.adoc
for i in $(openstack resource list -n 2 $stack_name | grep PRO |grep deployment_bastion_node_cleanup | awk -F'|' '{printf $7}'); do
  openstack stack resource signal $stack_name deployment_bastion_node_cleanup
  echo $stack_name
  echo "========================================="
done
