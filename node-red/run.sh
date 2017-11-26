#!/bin/bash
CONFIG_PATH=/data/options.json

SSL=$(jq --raw-output ".ssl" $CONFIG_PATH)
KEYFILE=$(jq --raw-output ".keyfile" $CONFIG_PATH)
CERTFILE=$(jq --raw-output ".certfile" $CONFIG_PATH)
USER_COUNT=$(jq --raw-output ".users | length" $CONFIG_PATH)

# Create /share/node-red folder
if [ ! -d /share/node-red ]; then
  echo "[INFO] Creating /share/node-red folder"
  mkdir -p /share/node-red
fi

# Migrate existing config files to handle upgrades from previous version
if [ -e /data/settings.js ] && [ ! -e /share/node-red/settings.js ]; then
  echo "[INFO] Migrating existing config from /data to /share/node-red"
  mv -f /data/* /share/node-red/
  mv -f /data/.* /share/node-red/
  mv -f /share/node-red/options.json $CONFIG_PATH
fi

if [ ! -e /share/node-red/settings.js ]; then
  echo "[INFO] Creating default settings"
  cp /settings.js /share/node-red/settings.js
fi

# Add ssl configs
if [ "$SSL" == "true" ]; then
  echo "[INFO] Enabling SSL"
  sed -i 's/.*var fs = require("fs")/var fs = require("fs")/g' /share/node-red/settings.js
  sed -i '/https: {/,/}/ s/\/\///' /share/node-red/settings.js
  sed -i "s/.*key: fs.readFileSync('.*'),/        key: fs.readFileSync(\'\/ssl\/$KEYFILE\'),/g" /share/node-red/settings.js
  sed -i "s/.*cert: fs.readFileSync('.*')/        cert: fs.readFileSync(\'\/ssl\/$CERTFILE\')/g" /share/node-red/settings.js
else
  echo "[INFO] Disabling SSL"
  sed -i 's/.*var fs = require("fs")/\/\/var fs = require("fs")/g' /share/node-red/settings.js
  sed -i '/^[ ]*https: {/,/}/ s/^[ ]*/    \/\//' /share/node-red/settings.js
  sed -i "s/.*key: fs.readFileSync/    \/\/    key: fs.readFileSync/g" /share/node-red/settings.js
  sed -i "s/.*cert: fs.readFileSync/    \/\/    cert: fs.readFileSync/g" /share/node-red/settings.js
fi

if [ "$USER_COUNT" == "0" ]; then
  echo "[INFO] Disabling Authentication"
  sed -i '/^[ ]*adminAuth: {/,/},/ s/^[ ]*/    \/\//' /share/node-red/settings.js
else
  echo "[INFO] Installing node-red-admin"
  npm install -g node-red-admin
  # sed -i '/adminAuth: {/,/},/ s/\/\///' /share/node-red/settings.js

  echo "[INFO] Updating users"
  sed '/adminAuth:/Q' /share/node-red/settings.js > /share/node-red/settings.js.new
  echo "    adminAuth: {" >> /share/node-red/settings.js.new
  echo "       type: \"credentials\"," >> /share/node-red/settings.js.new
  echo "       users: [" >> /share/node-red/settings.js.new

  for (( i=0; i < "$USER_COUNT"; i++ )); do
    USERNAME=$(jq --raw-output ".users[$i].username" $CONFIG_PATH)
    PASSWORD=$(jq --raw-output ".users[$i].password" $CONFIG_PATH)
    HASH=$(echo $PASSWORD | node-red-admin hash-pw | cut -d " " -f 2)
    PERMISSIONS=$(jq --raw-output ".users[$i].permissions" $CONFIG_PATH)
    if [ "$i" != "0" ]; then
      echo "                ," >> /share/node-red/settings.js.new
    fi
    echo "[INFO] Adding user $USERNAME"
    echo "                {" >> /share/node-red/settings.js.new
    echo "                  username: \"$USERNAME\"," >> /share/node-red/settings.js.new
    echo "                  password: \"$HASH\"," >> /share/node-red/settings.js.new
    echo "                  permissions: \"$PERMISSIONS\"" >> /share/node-red/settings.js.new
    echo "                }" >> /share/node-red/settings.js.new
  done

  echo "       ]" >> /share/node-red/settings.js.new
  echo "    }," >> /share/node-red/settings.js.new
  echo >> /share/node-red/settings.js.new

  sed -n -e '/To password protect the node-defined HTTP endpoints/,$p' /share/node-red/settings.js >> /share/node-red/settings.js.new

  mv -f /share/node-red/settings.js /share/node-red/settings.js.old
  mv -f /share/node-red/settings.js.new /share/node-red/settings.js
fi

cd /usr/src/node-red
npm start -- --userDir /share/node-red
