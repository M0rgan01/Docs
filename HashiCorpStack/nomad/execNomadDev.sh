
DEFAULT_IP=172.17.0.2

IP="${1:-$DEFAULT_IP}"

echo "[Unit]
Description=Nomad Service Discovery Agent
Documentation=https://www.nomad.io/
After=network-online.target
Wants=network-online.target

[Service]
ExecStart=/usr/local/bin/nomad agent \
  -node=$IP \
  -bind=$IP \
  -config=/home/vagrant/temp/nomadConf.hcl \
  -network-interface=enp0s8 \
  -dev

ExecReload=/bin/kill -HUP $MAINPID
Restart=on-failure

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/nomad.service

systemctl enable nomad.service
systemctl start nomad