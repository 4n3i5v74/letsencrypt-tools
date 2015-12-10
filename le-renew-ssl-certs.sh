#! /bin/sh

# Filename: le-renew
# Description: it will automatically renew all the certificates

LE=/opt/letsencrypt/letsencrypt-auto

service apache2 stop

for f in /etc/letsencrypt/renewal/*conf;
do
    filename=$(basename $f);
    domain=${filename%.*}
    echo "Renew domain: $domain ..."
    $LE --renew-by-default --domains $domain certonly
done

service apache2 start
