
DEFAULT_SERVER_IP=172.17.0.2
DEFAULT_IP=172.17.0.3

NOMAD_IP="${1:-$DEFAULT_IP}"
NOMAD_SERVER_IP="${2:-DEFAULT_SERVER_IP}"

echo "[Unit]
Description=Nomad Service Discovery Agent
Documentation=https://www.nomad.io/
After=network-online.target
Wants=network-online.target

[Service]
ExecStart=/usr/local/bin/nomad agent \
  -node=$NOMAD_IP \
  -bind=$NOMAD_IP \
  -client \
  -network-interface=enp0s8 \
  -data-dir=/var/lib/nomad \
  -retry-join=$NOMAD_SERVER_IP \
  -encrypt=TeLbPpWX41zMM3vfLwHHfQ==

ExecReload=/bin/kill -HUP $MAINPID
Restart=on-failure

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/nomad.service

systemctl enable nomad.service
systemctl start nomad