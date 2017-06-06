#!/bin/bash

if [ $# != 1 ];then
  echo "Usage: $0 $LB/$Master"
  exit 1
fi

# Login and create app
oc login $1
oc new-project ghuang-test
oc new-app cakephp-mysql-example
oc logs -f bc/cakephp-mysql-example

# Monitor the app route
while :; do curl -s cakephp-mysql-example-ghuang-test.cloudapps.ocp3.ghuang.com --output /dev/null -w "-status %{http_code} $(date)\n"; sleep 1; done

# Update the stack
openstack stack update --timeout 1200 -e ha-master-dedicated-flannel.yaml -t /usr/share/openshift-heat-templates/openshift.yaml ha-master-dedicated-flannel

