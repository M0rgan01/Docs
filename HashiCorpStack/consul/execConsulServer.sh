
DEFAULT_IP=172.17.0.2

IP="${1:-$DEFAULT_IP}"

/usr/local/bin/consul agent \
  -node=$IP \
  -bind=$IP \
  -client=0.0.0.0 \
  -ui \
  -server \
  -bootstrap-expect=1 \
  -advertise=$IP \
  -data-dir=/var/lib/consul \
  -encrypt=TeLbPpWX41zMM3vfLwHHfQ==
