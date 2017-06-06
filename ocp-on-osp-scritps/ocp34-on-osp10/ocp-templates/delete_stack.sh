#!/bin/bash

if [ $# -ne 1 ]; then 
    echo "Usage: $(basename $0) <stack_id/stack_name>" 
    exit 1
fi

heat stack-show $1
if [ $? != 0 ];then
   echo "Not found the stack!"
   exit 1
fi

if [ -n $(heat stack-show $1 |grep DELETE_IN_PROGRESS) ];then
   heat stack-delete $1
   sleep 10
fi

for i in $(heat resource-list -n 2 $1|grep PRO |grep deployment_bastion_node_cleanup | awk -F'|' '{printf $7}'); do
  heat resource-signal $i deployment_bastion_node_cleanup
  echo $i
  echo "========================================="
done


