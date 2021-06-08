
################# installation consul  ###########################

wget https://releases.hashicorp.com/consul/1.9.6/consul_1.9.6_linux_amd64.zip
unzip consul_1.9.6_linux_amd64.zip
mv consul /usr/local/bin/
groupadd --system consul
useradd -s /sbin/nologin --system -g consul consul
mkdir -p /var/lib/consul
chown -R consul:consul /var/lib/consul
chmod -R 775 /var/lib/consul
mkdir /etc/consul.d
chown -R consul:consul /etc/consul.d

consul agent -server -data-dir=/var/lib/consul -config-dir=/etc/consul.d -ui -bind=127.0.0.1 -bootstrap-expect=1

##################################################################