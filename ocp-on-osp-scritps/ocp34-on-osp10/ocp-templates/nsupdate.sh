#!/bin/bash

ask() {

    while [[ $ans == "" ]]
    do
        read -p "${@}"  ans
    done

    echo $ans
}

forward_zone_update() { 
    local rr=${@}
    echo "
    server $DNS_SERVER
    zone $DNS_ZONE
    update add $rr
    show
    send" | nsupdate -k $NSUPDATE_KEY 
}

delete_record() { 
    local rr=${@}
    echo "
    server $DNS_SERVER
    zone $DNS_ZONE
    update delete $rr
    show
    send" | nsupdate -k $NSUPDATE_KEY 
}


#
## Global Variable
#
DNS_IP="10.0.0.212"
DNS_SERVER="10.0.0.212"
DNS_ZONE="ocp3.ghuang.com"
DIG_CMD='dig +noquestion +nocmd +nostat +nocomments'
NSUPDATE_KEY="ghuang_dns_update.key"

#update_rr_a=$( ask "Enter FQDN of Record (Ex. xyz.${DNS_ZONE}) :-")
update_rr_a="*.cloudapps.$DNS_ZONE"
if [ -z $1 ];then
  update_rr=$( ask "Enter IP of Record :-")
else
  update_rr=$1
fi
found_rr=$($DIG_CMD @${DNS_IP} AXFR ${DNS_ZONE} | grep  ^"${update_rr_a%.$DNS_ZONE}" | tee /tmp/rr.tmp )

echo "Checking ${update_rr_a}..."

if [[ -z "${found_rr}" ]] 
then
    echo "${update_rr_a} does exists"
    echo "${update_rr_a} adding to ${DNS_ZONE}"
    forward_zone_update "${update_rr_a} 86400 IN A ${update_rr}"
    echo "Done!!"
else
    echo "${update_rr_a} already exists"
    ans=$(ask "Do you want to Delete RR and want to re-add(y/n?)")
    case $ans in
        [yY]|[yY][eE][sS]) while read r; 
                   do delete_record $r ; 
                               done < /tmp/rr.tmp ;;

        [nN]|[nN][oO])     exit 1 ;;
    esac
    forward_zone_update "${update_rr_a} 86400 IN A ${update_rr}"
    echo "Done!!"
fi
