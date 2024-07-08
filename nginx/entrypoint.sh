#!/bin/bash

# First attempt to renew certificates
certbot renew --nginx

# Start nginx in the foreground
nginx -g 'daemon off;'

# schedule a cron job or a loop to periodically renew certificates
while :; do
    sleep 12h
    certbot renew --nginx
done
