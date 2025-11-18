#!/bin/bash

# -------------------------------------------------------
#  LAMP Installer Script (Apache + MariaDB + PHP)
#  Author: Carlos Cabrera
#  Usage: sudo bash install_lamp.sh
# -------------------------------------------------------

# Colors
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
BLUE="\e[34m"
NC="\e[0m"  # No Color / reset

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_ok() {
    echo -e "${GREEN}[OK]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

check_root() {
    if [ "$EUID" -ne 0 ]; then
        log_error "You must run this script with sudo or as root."
        exit 1
    fi
}

update_system() {
    log_info "Updating package lists..."
    apt-get update -y
    apt-get upgrade -y
}

install_php() {
    log_info "Installing PHP..."
    apt-get install -y php libapache2-mod-php php-mysql
}

install_mariadb() {
    log_info "Installing MariaDB..."
    apt-get install -y mariadb-server
}

install_apache() {
    log_info "Installing Apache..."
    apt-get install -y apache2
    systemctl enable apache2
    systemctl start apache2
}

create_vhost() {
    log_info "Configuring VirtualHost..."

    # Ask for domain and validate using a loop
    while true; do
        read -p "Enter the domain for your site (e.g. lamp.local): " DOMAIN

        # Empty input = error
        if [ -z "$DOMAIN" ]; then
            log_error "Domain cannot be empty."
            continue
        fi

        # Simple regex validation
        if [[ "$DOMAIN" =~ ^[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$ ]]; then
            break
        else
            log_error "Invalid domain. Valid examples:"
            echo "  → mydomain.com"
            echo "  → lamp.local"
            echo "  → example.net"
        fi
    done

    WEBROOT="/var/www/$DOMAIN"

    log_info "Creating web root directory at $WEBROOT..."
    mkdir -p "$WEBROOT"
    chown -R www-data:www-data "$WEBROOT"

    log_info "Creating index.php..."
    cat <<EOF > "$WEBROOT/index.php"
<?php
phpinfo();
?>
EOF

    log_info "Creating VirtualHost at /etc/apache2/sites-available/$DOMAIN.conf..."
    cat <<EOF > "/etc/apache2/sites-available/$DOMAIN.conf"
<VirtualHost *:80>
    ServerName $DOMAIN
    DocumentRoot $WEBROOT

    <Directory $WEBROOT>
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/$DOMAIN-error.log
    CustomLog \${APACHE_LOG_DIR}/$DOMAIN-access.log combined
</VirtualHost>
EOF

    log_info "Enabling site and reloading Apache..."
    a2ensite "$DOMAIN.conf"
    a2dissite 000-default.conf
    systemctl reload apache2

    log_ok "VirtualHost created. Test it at: http://$DOMAIN"
}

install_ufw() {
    log_info "Installing UFW..."
    apt-get install -y ufw

    log_info "Configuring UFW rules (SSH + Apache)..."
    ufw allow OpenSSH
    ufw allow "Apache Full"

    log_ok "Enabling UFW..."
    ufw --force enable
}

# Main flow
check_root
update_system
install_php
install_mariadb
install_apache
create_vhost
install_ufw

log_ok "LAMP installation completed."
