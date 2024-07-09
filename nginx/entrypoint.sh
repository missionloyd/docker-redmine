#!/bin/bash

# Ensure certificates exist
if [ ! -f /etc/letsencrypt/live/redmine.powertheoryinc.com/fullchain.pem ]; then
    certbot certonly --standalone -d redmine.powertheoryinc.com --non-interactive --agree-tos -m ${CERTBOT_EMAIL}
fi

# Start nginx in the foreground
nginx -g 'daemon off;'

# schedule a cron job or a loop to periodically renew certificates
while :; do
    sleep 12h
    certbot renew --nginx
done
