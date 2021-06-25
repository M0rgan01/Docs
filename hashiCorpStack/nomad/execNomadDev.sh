
DEFAULT_IP=172.16.0.2

NOMAD_IP="${1:-$DEFAULT_IP}"

echo "[Unit]
Description=Nomad Service Discovery Agent
Documentation=https://www.nomadproject.io/
After=network-online.target
Wants=network-online.target

[Service]
ExecStart=/usr/local/bin/nomad agent \
  -node=$NOMAD_IP \
  -bind=$NOMAD_IP \
  -consul-address=$NOMAD_IP:8500 \
  -dev \
  -config=/home/vagrant/temp/nomadDevConfig.hcl

ExecReload=/bin/kill -HUP $MAINPID
Restart=on-failure

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/nomad.service

systemctl enable nomad.service
systemctl start nomad
