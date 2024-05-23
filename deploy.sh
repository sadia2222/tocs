#!/bin/bash

# Define variables
WEBROOT="/var/www/myapp"

# Create the web root directory if it doesn't exist
sudo mkdir -p $WEBROOT

# Copy the HTML file to the web root
sudo cp index.html $WEBROOT/index.html

# Create a new Nginx server block configuration
NGINX_CONF="/etc/nginx/sites-available/myapp"

sudo bash -c "cat > $NGINX_CONF" <<EOL
server {
    listen 8081;
    server_name _;

    location / {
        root $WEBROOT;
        index index.html;
        try_files \$uri \$uri/ =404;
    }
}
EOL

# Enable the new server block configuration
sudo ln -sf $NGINX_CONF /etc/nginx/sites-enabled/

# Test Nginx configuration and restart Nginx
sudo nginx -t && sudo systemctl restart nginx
