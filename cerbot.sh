logger() {
    echo "$(date '+%Y/%m/%d %H:%M:%S') certbot.sh: $1"
}

logger "Installing Certbot"

apt update; apt -y upgrade

apt install certbot

IFS= read -p "Do you want to install Cloudflare DNS plugin: (Only accept yes) " install_cf
if [[ $install_cf == "yes" ]]; then
    logger "Installing certbot-dns-cloudflare DNS challange automation"
    apt install python3-pip -y
    pip install certbot-dns-cloudflare

    IFS= read -sp "Please enter the Cloudflare access token: " cf_token
    if [[ $cf_token == "" ]]; then
        logger "Failed to configure Cloudflare DNS challange. No token"
    else
        logger "Saving credentials to ~/.secrets/certbot/cloudflare.ini"
        mkdir -p ~/.secrets/certbot/
        echo "dns_cloudflare_api_token = $cf_token" > ~/.secrets/certbot/cloudflare.ini
        chmod 600 ~/.secrets/certbot/cloudflare.ini
    fi
fi
