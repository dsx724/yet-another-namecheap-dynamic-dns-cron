# Yet Another Namecheap Dynamic DNS Cron
## Purpose
This script updates Namecheap Dynamic DNS records based on the public IP address attached to this host. It is ideal for DMZ scenarios so you can connect remotely to your server from the internet.

## Usage
You need

	sudo apt-get install -y dnsutils wget

crontab to check every 5 minutes:

	*/5 * * * * PUT_ABSOLUTE_PATH_TO_REPO_HERE/yet-another-namecheap-dynamic-dns-cron/cron.sh FQDN SECRET [RESOLVER]

You need to add a resolver IP if your local network domain matches the FQDN domain.

## Design
1. It looks up the current IP address of the FQDN using the RESOLVER if provided.
2. It digs OpenDNS servers to find your IP address.
3. If they do not match, ping the Namecheap DDNS server to update the record using the SECRET.

## Known Issues
*	This does not account for 3 level domains. Feel free to send a pull request.
*	This is very simple and may not work for complex (funny) network setups.

