#!/bin/bash

# Expects service to be called app in docker-compose.yml
SERVICE_ID=$(docker ps --format "{{.Names}}" | grep "app")

enable_xdebug() {
  docker exec -i $SERVICE_ID bash -c \
          '[ -f /usr/local/etc/php/disabled/docker-php-ext-xdebug.ini ] && cd /usr/local/etc/php/ && mv disabled/docker-php-ext-xdebug.ini conf.d/ || echo "Xdebug already enabled"'

  docker restart $SERVICE_ID

  docker exec -i $SERVICE_ID bash -c '$(php -m | grep -q Xdebug) && echo "Status: Xdebug ENABLED" || echo "Status: Xdebug DISABLED"'
}

disabled_xdebug() {
  docker exec -i $SERVICE_ID bash -c \
          '[ -f /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini ] && cd /usr/local/etc/php/ && mkdir -p disabled/ && mv conf.d/docker-php-ext-xdebug.ini disabled/ || echo "Xdebug already disabled"'

  docker restart $SERVICE_ID

  docker exec -i $SERVICE_ID bash -c '$(php -m | grep -q Xdebug) && echo "Status: Xdebug ENABLED" || echo "Status: Xdebug DISABLED"'
}

# Tạo menu prompt
PS3="Select option (press Ctrl+C to exit): "
options=("Enable" "Disable" "Exit")

select opt in "${options[@]}"; do
    case $opt in
        "Enable")
            enable_xdebug
            break
            ;;
        "Disable")
            disabled_xdebug
            break
            ;;
        "Exit")
            exit 0
            break
            ;;
        *) echo "Option not found";;
    esac
done
