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

- Mac append one line

https://stackoverflow.com/questions/5171901/sed-command-find-and-replace-in-file-and-overwrite-file-doesnt-work-it-empties

https://unix.stackexchange.com/questions/52131/sed-on-osx-insert-at-a-certain-line

https://unix.stackexchange.com/questions/52131/sed-on-osx-insert-at-a-certain-line

```
sed -i '' '/    always_on                = true/a\'$'\n''\ \ \ \ min_tls_version          = \"1.2\"\'$'\n' $(grep -rl "always.*true" . | grep -v "terraform-provider-azurerm")
```

```
sed -i '/\ \ inventory/{s/.*/&\n<% if (not defined?(skip_post_tasks)) or (defined?(skip_post_tasks) and "#{skip_post_tasks}" == "false") %>/;:a;n;ba}' *
sed -i '$a\<% end %>' hosts.1master+1etcd
```

- add 3.7 directory

```
sed -i s#aos36-devel-install#aos37-devel-install#g `grep -rl "aos36-devel-install" .`
sed -i s#all/3.6#all/3.7#g `grep -rl "all\/3\.6" .`
sed -i s#AtomicOpenShift/3.6#AtomicOpenShift/3.7#g `grep -rl "AtomicOpenShift\/3\.6" .`
sed -i s#v3.6.0.x#v3.7.0.x#g `grep -rl "v3\.6\.0\.x" .`
sed -i s#openshift_release:\ v3.6#openshift_release:\ v3.7#g `grep -rl "openshift_release:\ v3\.6" .`
for f in `find ./ -name *36*`; do mv "${f}" "`echo ${f} | sed "s/36/37/"`";done
sed -i s#aos-36#aos-37#g `grep -rl "aos-36" .`
sed -i s#3.6#3.7#g `grep -rl "3\.6" .`

```
