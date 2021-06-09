
DEFAULT_SERVER_IP=172.17.0.2
DEFAULT_IP=172.17.0.3

IP="${1:-$DEFAULT_IP}"
SERVER_IP="${2:-DEFAULT_SERVER_IP}"

/usr/local/bin/nomad agent \
  -node="$IP" \
  -bind="$IP" \
  -client \
  -data-dir=/var/lib/nomad \
  -retry-join="$SERVER_IP" \
  -encrypt=TeLbPpWX41zMM3vfLwHHfQ==
