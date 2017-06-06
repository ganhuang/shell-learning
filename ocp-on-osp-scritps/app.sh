#!/bin/bash

if [ $# != 1 ];then
  echo "Usage: $0 $LB/$Master"
  exit 1
fi

# Login and create app
oc login $1
app_name="dancer-mysql-example"
#app_name="cakephp-mysql-example"
oc new-project ghuang-test
oc new-app $app_name
oc logs -f bc/$app_name

# Monitor the app route
while :; do curl -s $app_name-ghuang-test.cloudapps.ocp3.ghuang.com --output /dev/null -w "-status %{http_code} $(date)\n"; sleep 1; done

# Update the stack
openstack stack update --timeout 1200 -e ha-master-dedicated-flannel.yaml -t /usr/share/openshift-heat-templates/openshift.yaml ha-master-dedicated-flannel

