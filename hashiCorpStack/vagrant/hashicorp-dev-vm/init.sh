echo "Installing Docker..."
sudo apt-get update
sudo apt-get remove docker docker-engine docker.io
echo '* libraries/restart-without-asking boolean true' | sudo debconf-set-selections
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg |  sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) \
      stable"
sudo apt-get update
sudo apt-get install -y docker-ce
# Restart docker to make sure we get the latest version of the daemon if there is an upgrade
sudo service docker restart
# Make sure we can actually use docker as the vagrant user
sudo usermod -aG docker vagrant
sudo docker --version

# Packages required for nomad & consul
sudo apt-get install unzip curl vim -y

# Create nomad volumes directory
sudo mkdir -p $HOME/volumes/postgres

echo "Installing Nomad..."
NOMAD_VERSION=1.0.1
cd /tmp/
curl -sSL https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip -o nomad.zip
unzip nomad.zip
sudo mv nomad /usr/local/bin/
# config directory
sudo mkdir -p /home/vagrant/etc/nomad.d
sudo chmod a+w /home/vagrant/etc/nomad.d


echo "Installing Consul..."
CONSUL_VERSION=1.9.0
curl -sSL https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip > consul.zip
unzip consul.zip
sudo mv consul /usr/local/bin/
sudo mkdir -p /var/lib/consul
sudo chmod -R 775 /var/lib/consul
# config directory
sudo mkdir -p /home/vagrant/etc/consul.d
sudo chmod a+w /home/vagrant/etc/consul.d

echo "Installing Vault..."
VAULT_VERSION=1.7.3
curl -sSL https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip -o vault.zip
unzip vault.zip
sudo mv vault /usr/local/bin/
# config directory
sudo mkdir -p /home/vagrant/etc/vault.d
sudo chmod a+w /home/vagrant/etc/vault.d


echo "Installing Hey..."
sudo apt-get update
sudo apt-get install -y hey