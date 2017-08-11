#armhf:FROM nodered/node-red-docker:rpi
#amd64:FROM nodered/node-red-docker:slim

WORKDIR /usr/src/node-red

USER root

RUN ARCH= && dpkgArch="$(dpkg --print-architecture)" \
  && case "${dpkgArch##*-}" in \
    amd64) \
    apk add --no-cache jq;; \
    armhf) \
    apt-get update && apt-get install -y jq;; \
    *) echo "unsupported architecture"; exit 1 ;; \
  esac

# Expose tcp/1880
EXPOSE 1880

# Environment variable holding file path for flows configuration
ENV FLOWS=flows.json

COPY settings.js /
COPY run.sh /
RUN chmod a+x /run.sh
CMD [ "/run.sh" ]
