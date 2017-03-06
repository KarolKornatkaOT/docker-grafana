FROM grafana/grafana:4.1.2

ENV GF_PATHS_PLUGINS=/grafana-plugins

RUN grafana-cli --pluginsDir "${GF_PATHS_PLUGINS}" plugins install alexanderzobnin-zabbix-app

