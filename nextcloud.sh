#!/bin/env bash

echo "Updating box....."
echo "======================================================================"
apt update
apt -y upgrade
apt -y install vim wget gpg

echo "Installing required packages....."
echo "======================================================================"
apt -y install nginx mariadb-server
apt -y install php7.4-gd php7.4-mysql php7.4-curl php7.4-mbstring php7.4-intl
apt -y install php7.4-gmp php7.4-bcmath php-imagick php7.4-xml php7.4-zip php7.4-fpm

echo "Starting & enabling MySQL server......."
systemctl start mysql
systemctl enable mysql

echo "Setting up Nextcloud database...."
echo "======================================================================"
db_user="next-admin"
db_pass="$(tr -dc A-Za-z0-9 </dev/urandom | head -c 15)"

#read -sp "Nextcloud database password: " db_pass
#if [[ $db_pass == "" ]]; then
#    echo "Database password can't be empty"
#    exit 1
#fi

echo "Creating Nextcloud database user and database"
cat <<EOF | mysql --user=root
CREATE USER '$db_user'@'localhost' IDENTIFIED BY '$db_pass';
CREATE DATABASE IF NOT EXISTS nextcloud CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
GRANT ALL PRIVILEGES ON nextcloud.* TO '$db_user'@'localhost';
FLUSH PRIVILEGES;
EOF

echo "Check the user and permissions created"
cat <<EOF | mysql --user=root
SHOW GRANTS FOR '$db_user'@'localhost';
EOF

printf "\n\n"
echo "=================== Nextcloud database credentials ==================="
echo "Username: $db_user"
echo "Password: $db_pass"
echo "======================================================================"
printf "\n\n"

read -p "Press enter to continue"

echo "Installing Nextcloud....."
echo "======================================================================"

mkdir nextcloud-downloads
cd nextcloud-downloads

echo "Downloading assets...."
wget https://download.nextcloud.com/server/releases/latest.tar.bz2
wget https://download.nextcloud.com/server/releases/latest.tar.bz2.md5


echo "Validating package integrity...."
if ! md5sum --status -c latest.tar.bz2.md5; then
    echo "Package corrupted!"
    exit 1
fi

echo "Extracting Nextcloud server files...."
tar -xjvf latest.tar.bz2 -C /var/www/

echo "Configuring Nginx...."

read -p "Nextcloud URL: " domain_name

if [[ $domain_name == "" ]]; then
    echo "Domain name not given! Server will respond to any server name requests"
	domain_name='_'
fi

cat <<\EOF > /etc/nginx/sites-enabled/nextcloud.conf
upstream php-handler {
    server unix:/var/run/php/php7.4-fpm.sock;
}

server {
    listen 80;
    listen [::]:80;
    server_name {{ domain }};

    client_max_body_size 10G;
    fastcgi_buffers 64 4K;

    gzip on;
    gzip_vary on;
    gzip_comp_level 4;
    gzip_min_length 256;
    gzip_proxied expired no-cache no-store private no_last_modified no_etag auth;
    gzip_types application/atom+xml application/javascript application/json application/ld+json application/manifest+json application/rss+xml application/vnd.geo+json application/vnd.ms-fontobject application/x-font-ttf application/x-web-app-manifest+json application/xhtml+xml application/xml font/opentype image/bmp image/svg+xml image/x-icon text/cache-manifest text/css text/plain text/vcard text/vnd.rim.location.xloc text/vtt text/x-component text/x-cross-domain-policy;

    add_header Referrer-Policy                      "no-referrer"   always;
    add_header X-Content-Type-Options               "nosniff"       always;
    add_header X-Download-Options                   "noopen"        always;
    add_header X-Frame-Options                      "SAMEORIGIN"    always;
    add_header X-Permitted-Cross-Domain-Policies    "none"          always;
    add_header X-Robots-Tag                         "none"          always;
    add_header X-XSS-Protection                     "1; mode=block" always;

    fastcgi_hide_header X-Powered-By;

    root /var/www/nextcloud;

    index index.php index.html /index.php$request_uri;

    location = / {
        if ( $http_user_agent ~ ^DavClnt ) {
            return 302 /remote.php/webdav/$is_args$args;
        }
    }

    location = /robots.txt {
        allow all;
        log_not_found off;
        access_log off;
    }

    location ^~ /.well-known {
        location = /.well-known/carddav { return 301 /remote.php/dav/; }
        location = /.well-known/caldav  { return 301 /remote.php/dav/; }

        location /.well-known/acme-challenge    { try_files $uri $uri/ =404; }
        location /.well-known/pki-validation    { try_files $uri $uri/ =404; }

        return 301 /index.php$request_uri;
    }

    location ~ ^/(?:build|tests|config|lib|3rdparty|templates|data)(?:$|/)  { return 404; }
    location ~ ^/(?:\.|autotest|occ|issue|indie|db_|console)                { return 404; }

    location ~ \.php(?:$|/) {
        fastcgi_split_path_info ^(.+?\.php)(/.*)$;
        set $path_info $fastcgi_path_info;

        try_files $fastcgi_script_name =404;

        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param PATH_INFO $path_info;
        fastcgi_param HTTPS on;

        fastcgi_param modHeadersAvailable true;         # Avoid sending the security headers twice
        fastcgi_param front_controller_active true;     # Enable pretty urls
        fastcgi_pass php-handler;

        fastcgi_intercept_errors on;
        fastcgi_request_buffering off;
    }

    location ~ \.(?:css|js|svg|gif)$ {
        try_files $uri /index.php$request_uri;
        expires 6M;         # Cache-Control policy borrowed from `.htaccess`
        access_log off;     # Optional: Don't log access to assets
    }

    location ~ \.woff2?$ {
        try_files $uri /index.php$request_uri;
        expires 7d;         # Cache-Control policy borrowed from `.htaccess`
        access_log off;     # Optional: Don't log access to assets
    }

    location /remote {
        return 301 /remote.php$request_uri;
    }


    location / {
        try_files $uri $uri/ /index.php$request_uri;
    }
EOF

sed -i "s/{{ domain }}/$domain_name/g" /etc/nginx/sites-enabled/nextcloud.conf
