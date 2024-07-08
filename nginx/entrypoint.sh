#!/bin/bash

# Ensure certificates exist
if [ ! -f /etc/letsencrypt/live/redmine.powertheoryinc.com/fullchain.pem ]; then
    certbot certonly --standalone -d redmine.powertheoryinc.com --non-interactive --agree-tos -m ${CERTBOT_EMAIL}
fi

# Generate key, CSR, and self-signed certificate
openssl genrsa -out /redmine.key 2048
openssl req -new -key /redmine.key -out /redmine.csr -subj "/C=US/ST=WY/L=Laramie/O=PowerTheoryInc/OU=Operations/CN=powertheoryinc.com"
openssl x509 -req -days 365 -in /redmine.csr -signkey /redmine.key -out /redmine.crt
openssl dhparam -out /dhparam.pem 2048

# Copy the generated files to the appropriate locations
mkdir -p /etc/ssl/certs/
cp /redmine.key /etc/ssl/certs/
cp /redmine.crt /etc/ssl/certs/
cp /dhparam.pem /etc/ssl/certs/
chmod 400 /etc/ssl/certs/redmine.key

# Start nginx in the foreground
nginx -g 'daemon off;'

# Schedule a cron job or a loop to periodically renew certificates
while :; do
    sleep 12h
    certbot renew --nginx
done
