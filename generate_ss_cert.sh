#!/bin/bash

# input arg for domain name
domain=$1
if [ -z "$domain" ];
    then
        echo "Please provide a domain name. It is a required input."
        exit
fi

# create output directory
if [ ! -d "$domain" ];
    then
        echo "Creating domain directory for $domain..."
        mkdir -p $domain
    else
        echo "Domain directory found."
fi

# create crt and key files
echo "Generating self-signed certificates for $domain..."
openssl req -newkey rsa:4096 \
            -nodes \
            -sha256 \
            -keyout $domain/server.key \
            -x509 \
            -days 3650 \
            -out $domain/server.crt \
            -subj "/C=US/ST=PA/L=PA/O=IT/CN=$domain"

# create dhparam file
openssl dhparam -out $domain/dhparam.pem 2048
