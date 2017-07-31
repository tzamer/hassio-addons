#armhf:FROM nodered/node-red-docker:rpi
#amd64:FROM nodered/node-red-docker:slim

WORKDIR /usr/src/node-red

USER root

# RUN apt-get install jq
# RUN chown -R node-red:node-red /data

# COPY run.sh /
# RUN chmod a+x /run.sh

# USER node-red

# Expose tcp/1880
EXPOSE 1880

# Environment variable holding file path for flows configuration
ENV FLOWS=flows.json

# CMD [ "/run.sh" ]
CMD ["npm", "start", "--", "--userDir", "/data"]
