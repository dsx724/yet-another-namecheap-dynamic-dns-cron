#!/bin/bash
if [ -z "$1" -o -z "$2" ]; then
	echo "$0 FQDN SECRET"
	exit 1
fi
FQDN="$1"
SECRET="$2"
RECORD=${FQDN%.*.*}
HOST=${FQDN#$RECORD.}
CURRENT_IP=`nslookup $FQDN | grep '^Address: ' | cut -f 2 -d ' '`
TARGET_IP=`dig -4 +short myip.opendns.com @resolver1.opendns.com`
if [ "$CURRENT_IP" != "$TARGET_IP" ]; then
	echo "Updating Dynamic DNS for $FQDN from $CURRENT_IP to $TARGET_IP."
	wget -q -o /dev/null "https://dynamicdns.park-your-domain.com/update?host=$RECORD&domain=$HOST&password=$SECRET"
fi
