- Modify the line from the specified line to the end of the file under a folder in a batch

```
match_string=
replace_string=
target_string=

sed -i '34,${s#${replace_string}#${target_string}#g}' $(grep -rl  "${match_string}" ../../)

```

```
sed -i '34,${s#^      <%= defined?(zone)#        <%= defined?(zone)#g}' $(grep -rl  "<%= defined?(zone)" ../../ |grep -v openshift-ansible)

sed -i '34,${s#^      <%= defined?(ec2_subnet_id)#        <%= defined?(ec2_subnet_id)#g}' $(grep -rl  "<%= defined?(zone)" ../../ |grep -v openshift-ansible)
```
- append one line
```
sed -i '/  deployment_type: openshift-enterprise/a  \ \ openshift_disable_check\:\ disk_availability,memory_availability,package_availability,docker_image_availability,docker_storage,package_version' $(grep -rl "deployment_type\:\ openshift-enterprise" .)
```
