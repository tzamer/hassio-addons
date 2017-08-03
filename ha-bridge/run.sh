# Create /share/habridge folder
if [ ! -d /share/habridge ]; then
  echo "[INFO] Creating /share/habridge folder"
  mkdir -p /share/habridge
fi

# Migrate existing habridge.config file
if [ ! -d /data/habridge.config ]; then
	echo "[INFO] Migrating existing habridge.config from /data to /share/habridge"
	mv -f /data/habridge.config /share/habridge
fi

# Migrate existing options.json file
if [ ! -d /data/options.json ]; then
	echo "[INFO] Migrating existing options.json from /data to /share/habridge"
	mv -f /data/options.json /share/habridge
fi

# Migrate existing backup files
find /data -name '*.cfgbk' -exec echo "[INFO] Moving existing {} to /share/habridge" \; -exec mv {} /share/habridge \;

java -jar -Dconfig.file=/share/habridge/habridge.config -Djava.net.preferIPv4Stack=true /habridge/app.jar
