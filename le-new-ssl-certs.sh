#! /bin/sh

# Usage: le-new <domain>
# Description: it will generate certificates for our domain(s)

LE=/opt/letsencrypt/letsencrypt-auto
# Use comma separated values for multiple domain certificate
DOMAINS=$1

service apache2 stop
$LE --domains $DOMAINS --standalone --email sysadmin@mydomain.eus certonly
service apache2 start
