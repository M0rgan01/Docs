
NOMAD_VERSION=1.1.0

################# installation nomad  ###########################

echo "Installing Nomad..."
wget --no-check-certificate https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip
unzip nomad_${NOMAD_VERSION}_linux_amd64.zip
mv nomad /usr/local/bin/
mkdir -p /etc/nomad.d
chmod a+w /etc/nomad.d

##################################################################