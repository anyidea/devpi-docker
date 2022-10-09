#!/bin/bash
set -e

# If not set we use devpi host default value
if [ -z $DEVPISERVER_HOST ]; then
    DEVPISERVER_HOST=devpi
fi

# If not set we use devpi port default value
if [ -z $DEVPISERVER_PORT ]; then
    DEVPISERVER_PORT=4040
fi

sed -i -e "s/devpi_host:devpi_port/$DEVPISERVER_HOST:$DEVPISERVER_PORT/g" /etc/nginx/nginx.conf

if [ "$1" = 'nginx-daemon' ]; then
    exec nginx -g "daemon off;";
fi

exec "$@"