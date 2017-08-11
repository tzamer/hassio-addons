#!/bin/bash
CONFIG_PATH=/data/options.json

SSL=$(jq --raw-output ".ssl" $CONFIG_PATH)
KEYFILE=$(jq --raw-output ".keyfile" $CONFIG_PATH)
CERTFILE=$(jq --raw-output ".certfile" $CONFIG_PATH)

if [ ! -e /data/gogs/conf/app.ini ]; then
    if [ "$SSL" == "true" ]; then
        echo "[INFO] Cannot enable SSL until initial configuration is complete.  Please restart Gogs after completing configuration to enable SSL."
    fi
else
    # Add ssl configs
    sed -i '/PROTOCOL.*=/d' /data/gogs/conf/app.ini
    sed -i '/CERT_FILE.*=/d' /data/gogs/conf/app.ini
    sed -i '/KEY_FILE.*=/d' /data/gogs/conf/app.ini

    if [ "$SSL" == "true" ]; then
        echo "[INFO] Configuring SSL KEYFILE=/ssl/$KEYFILE CERTFILE=/ssl/$CERTFILE"
        sed -i "s/\[server\]/\[server\]\nPROTOCOL         = https\nCERT_FILE        = \/ssl\/$CERTFILE\nKEY_FILE         = \/ssl\/$KEYFILE/" /data/gogs/conf/app.ini
        sed -i "s/http:\/\//https:\/\//" /data/gogs/conf/app.ini
    else
        echo "[INFO] SSL Not Enabled"
        sed -i "s/https:\/\//http:\/\//" /data/gogs/conf/app.ini
    fi
fi

/app/gogs/docker/start.sh /bin/s6-svscan /app/gogs/docker/s6/
