#! /bin/sh

# Filename: le-renew
# Description: it will automatically renew all the certificates

LE=/opt/letsencrypt/letsencrypt-auto
domainsline=`grep -h domains /etc/letsencrypt/renewal/*`

# Download last version
$LE --help

service apache2 stop

#internal separator
IFS=$'\n'
for domains in $domainsline;
do
    domains=`echo ${domains//[[:blank:]]/} | cut -d= -f2`

    if [[ $domains != "None" ]];then
        domain=`echo $domains | cut -d, -f1`
        more=`echo $domains | cut -d, -f2`
        if [[ $more == "" ]];then
            # Single domain, use $domain
            $LE --renew-by-default certonly --domains $domain
        else
            # Multiple domains, use $domains
            $LE --renew-by-default certonly --domains $domains
        fi
    fi
done
