FROM oberthur/docker-ubuntu:16.04-20170303

MAINTAINER Karol Kornatka <k.kornatka@oberthur.com>

#URL where correct grafana pckg is located (can find on https://grafana.com/grafana/download)

ENV DOWNLOAD_URL="https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana_4.1.2-1486989747_amd64.deb"
ENV GF_PATHS_PLUGINS=/grafana-plugins

RUN apt-get update && \
    apt-get -y --no-install-recommends install libfontconfig curl ca-certificates && \
    apt-get clean && \
    curl ${DOWNLOAD_URL} > /tmp/grafana.deb && \
    dpkg -i /tmp/grafana.deb && \
    rm /tmp/grafana.deb && \
    grafana-cli --pluginsDir "${GF_PATHS_PLUGINS}" plugins install alexanderzobnin-zabbix-app && \
    curl -L https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64 > /usr/sbin/gosu && \
    chmod +x /usr/sbin/gosu && \
    apt-get remove -y curl && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

VOLUME ["/var/lib/grafana", "/var/log/grafana", "/etc/grafana"]

EXPOSE 3000

COPY ./run.sh /run.sh

ENTRYPOINT ["/run.sh"]
