# Use the official Nginx image as a parent image
FROM nginx:latest

# Install necessary packages including software-properties-common and certbot
RUN apt-get update && \
    apt-get install -y software-properties-common certbot python3-certbot-nginx

# Remove the default Nginx configuration files
RUN rm /etc/nginx/nginx.conf && \
    rm /etc/nginx/conf.d/default.conf

# Copy the custom Nginx configuration files from the local directory to the container
COPY nginx.conf /etc/nginx/
COPY project.conf /etc/nginx/conf.d/

# Set up a volume for Certbot certificates and logs
VOLUME ["/etc/letsencrypt", "/var/log/letsencrypt"]

# Expose HTTP and HTTPS ports
EXPOSE 80 443

# Set up a command or script to renew the SSL certificate
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Use the entrypoint script to handle cert renewals and start Nginx
ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
