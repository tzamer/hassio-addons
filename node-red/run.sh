CONFIG_PATH=/data/options.json

cd /data
# npm install node-red-node-smooth

jq --raw-output ".installnodes[]" $CONFIG_PATH | while read p; do echo "Ensuring $p is installed…"; npm install -g $p; done

cd /usr/src/node-red
npm start --userDir /data
