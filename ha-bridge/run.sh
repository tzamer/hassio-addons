# Create /share/habridge folder
if [ ! -d /share/habridge ]; then
  echo "[INFO] Creating /share/habridge folder"
  mkdir -p /share/habridge
fi

# Migrate existing config files to handle upgrades from previous version
if [ -e /data/habridge.config ] && [ ! -e /share/habridge/habridge.config ]; then
  # Migrate existing habridge.config file
  echo "[INFO] Migrating existing habridge.config from /data to /share/habridge"
  mv -f /data/habridge.config /share/habridge

  # Migrate existing options.json file
  if [ -e /data/options.json ] && [ ! -e /share/habridge/options.json ]; then
    echo "[INFO] Migrating existing options.json from /data to /share/habridge"
    mv -f /data/options.json /share/habridge
  fi

  # Migrate existing backup files
  find /data -name '*.cfgbk' \
    -exec echo "[INFO] Moving existing {} to /share/habridge" \; \
    -exec mv {} /share/habridge \;
fi

java -jar -Dconfig.file=/share/habridge/habridge.config -Djava.net.preferIPv4Stack=true /habridge/app.jar
