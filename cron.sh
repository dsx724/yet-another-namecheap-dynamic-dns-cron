#!/bin/bash
YANDD_lookupFQDN(){ #fqdn resolver
	if [ -z "$2" ]; then
		nslookup "$1" | grep '^Address: ' | cut -f 2 -d ' '
	else
		nslookup "$1" "$2" | grep '^Address: ' | cut -f 2 -d ' '
	fi
}
YANDD_findMyIP(){
	dig -4 +short myip.opendns.com @resolver1.opendns.com
}
YANDD_update(){ #fqdn target secret
	local record=${1%.*.*} #TODO: need to account for three component dn
	local host=${1#$record.}
	wget -q -o /dev/null -O /dev/null "https://dynamicdns.park-your-domain.com/update?host=$record&domain=$host&password=$3"
}
YANDD_main(){
	if [ -z "$1" -o -z "$2" ]; then
		echo "$0 FQDN SECRET [RESOLVER]"
		exit 1
	fi
	local ip_current=$(YANDD_lookupFQDN "$1" "$3")
	local ip_host=$(YANDD_findMyIP)
	if [ "$ip_current" != "$ip_host" ]; then
		echo "Updating Namecheap Dynamic DNS for $1 from $ip_current to $ip_host."
		YANDD_update "$1" "$ip_host" "$2"
	fi
}
YANDD_main "$@"
