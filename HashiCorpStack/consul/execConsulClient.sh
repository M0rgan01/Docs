
DEFAULT_SERVER_IP=172.17.0.2
DEFAULT_IP=172.17.0.3

IP="${1:-$DEFAULT_IP}"
SERVER_IP="${2:-DEFAULT_SERVER_IP}"

/usr/local/bin/consul agent \
  -node=$IP \
  -bind=$IP \
  -client=0.0.0.0 \
  -advertise=$IP \
  -data-dir=/var/lib/consul \
  -retry-join=$DEFAULT_SERVER_IP \
  -encrypt=TeLbPpWX41zMM3vfLwHHfQ==
