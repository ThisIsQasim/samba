FROM debian:buster-slim
RUN apt-get update

RUN export samba_version=4.9.1 \
 && export DEBIAN_FRONTEND=noninteractive \
 \
 && apt-get -q -y upgrade \
 && apt-get -q -y install samba \
 \
 && apt-get -q -y clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
 \
 && touch /var/lib/samba/registry.tdb

VOLUME ["/shares"]

EXPOSE 139 445

COPY scripts /usr/local/bin/

HEALTHCHECK CMD ["docker-healthcheck.sh"]
ENTRYPOINT ["entrypoint.sh"]

CMD [ "bash", "-c", "smbd -FS -d 2 < /dev/null" ]
