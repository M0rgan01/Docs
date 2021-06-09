
DEFAULT_IP=172.17.0.2

IP="${1:-$DEFAULT_IP}"

/usr/local/bin/nomad agent \
  -node="$IP" \
  -bind="$IP" \
  -server \
  -bootstrap-expect=1 \
  -data-dir=/var/lib/nomad \
  -encrypt=TeLbPpWX41zMM3vfLwHHfQ==
