
DEFAULT_IP=172.17.0.2

VAULT_IP="${1:-$DEFAULT_IP}"

echo "[Unit]
Description=Vault Service
Documentation=https://www.vaultproject.io/
After=network-online.target
Wants=network-online.target

[Service]
ExecStart=/usr/local/bin/vault server \
  -config=/home/vagrant/temp/vaultConf.hcl \
  -dev

ExecReload=/bin/kill -HUP $MAINPID
Restart=on-failure

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/vault.service

systemctl enable vault.service
systemctl start vault
