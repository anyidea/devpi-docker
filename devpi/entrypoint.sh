#!/usr/bin/env sh

set -e

if [ -z "${DEVPISERVER_HOST}" ]; then
    DEVPISERVER_HOST="0.0.0.0"
fi

if [ -z "${DEVPISERVER_PORT}" ]; then
    DEVPISERVER_PORT="4040"
fi

if [ ! -f "${DEVPISERVER_SERVERDIR}/.nodeinfo" ]; then
    echo "start initialization"
    devpi-init

    (
        echo "waiting for devpi-server start"
        sleep 10
        devpi use "http://${DEVPISERVER_HOST}:${DEVPISERVER_PORT}"
        devpi login root --password=""


        echo "setup password for root"
        devpi user -m root password="${DEVPISERVER_ROOT_PASSWORD}"


        echo "create user ${DEVPISERVER_USER}"
        devpi user -c "${DEVPISERVER_USER}" password="${DEVPISERVER_PASSWORD}"
        devpi logout  # logout from root
        devpi login "${DEVPISERVER_USER}" --password="${DEVPISERVER_PASSWORD}"


        echo "create index ${DEVPISERVER_USER}/${DEVPISERVER_MIRROR_INDEX}"
        devpi index -c "${DEVPISERVER_MIRROR_INDEX}" type=mirror mirror_url="${DEVPISERVER_SOURCE_MIRROR_URL}" mirror_web_url_fmt=${DEVPISERVER_SOURCE_MIRROR_URL}{name}/
        devpi index -c "${DEVPISERVER_LIB_INDEX}" bases="${DEVPISERVER_USER}/${DEVPISERVER_MIRROR_INDEX}"

        devpi logout
    ) &

else
    echo "skip initialization"
fi

exec "$@"