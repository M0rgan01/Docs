
DEFAULT_IP=172.17.0.2

CONSUL_IP="${1:-$DEFAULT_IP}"

echo "[Unit]
Description=Consul Service Discovery Agent
Documentation=https://www.consul.io/
After=network-online.target
Wants=network-online.target

[Service]
Restart=on-failure
ExecStart=/usr/local/bin/consul agent \
  -node=$CONSUL_IP \
  -bind=$CONSUL_IP \
  -ui \
  -server \
  -bootstrap-expect=1 \
  -data-dir=/var/lib/consul \
  -encrypt=TeLbPpWX41zMM3vfLwHHfQ==

ExecReload=/bin/kill -HUP $MAINPID

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/consul.service

systemctl enable consul.service
systemctl start consul
