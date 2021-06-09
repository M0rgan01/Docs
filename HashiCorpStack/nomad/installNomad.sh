
NOMAD_VERSION=1.1.0

################# installation nomad  ###########################

wget --no-check-certificate https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip
unzip nomad_${NOMAD_VERSION}_linux_amd64.zip
mv nomad /usr/local/bin/
groupadd --system nomad
useradd -s /sbin/nologin --system -g nomad nomad
mkdir -p /var/lib/nomad
chown -R nomad:nomad /var/lib/nomad
chmod -R 775 /var/lib/nomad
mkdir /etc/nomad.d
chown -R nomad:nomad /etc/nomad.d

##################################################################