#armhf:FROM gogs/gogs-rpi
#amd64:FROM gogs/gogs

RUN apk add --no-cache jq

COPY run.sh /
RUN chmod a+x /run.sh
CMD [ "/run.sh" ]
