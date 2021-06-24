
CONSUL_VERSION=1.9.6

################# installation consul  ###########################

echo "Installing Consul..."
wget --no-check-certificate https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip
unzip consul_${CONSUL_VERSION}_linux_amd64.zip
mv consul /usr/local/bin/
mkdir -p /var/lib/consul
chmod -R 775 /var/lib/consul
mkdir /etc/consul.d

##################################################################