
VAULT_VERSION=1.7.3

################# installation vault  ###########################

echo "Installing Vault..."
wget --no-check-certificate https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip
unzip vault_${VAULT_VERSION}_linux_amd64.zip
mv vault /usr/local/bin/
mkdir -p /etc/vault.d
chmod a+w /etc/vault.d

##################################################################