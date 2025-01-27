# Use Ubuntu as the base image
FROM ubuntu:latest

# NGINX is included as an example service.
# Feel free to remove and replace with your own
# Install Nginx and other necessary packages
RUN apt-get update && apt-get install -y \
    nginx \
    curl \
    unzip \
    && apt-get clean

# Copy a default Nginx configuration (optional)
RUN echo "server {\n\
    listen 80;\n\
    location / {\n\
        return 200 'Welcome to Nginx running in a Docker container!';\n\
        add_header Content-Type text/plain;\n\
    }\n\
}" > /etc/nginx/sites-available/default

# Ensure Nginx starts and runs in the foreground
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Add Senzing as the runtime layer
# This is for the newer version 4 of the SDK
#FROM senzing/senzingsdk-runtime
#This is for the older version 3 of the Senzing API runtime
FROM senzing/senzingapi-runtime

# Ensure Nginx binary is accessible in this final image
COPY --from=0 /usr/sbin/nginx /usr/sbin/nginx
COPY --from=0 /etc/nginx /etc/nginx

# Start Nginx by default
CMD ["nginx"]
