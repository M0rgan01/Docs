data_dir  = "/var/lib/nomad"

client {
  enabled = true
  network_interface = "enp0s8"
}

server {
  enabled = true
  bootstrap_expect = 3
  encrypt = "TeLbPpWX41zMM3vfLwHHfQ=="
  server_join {
    retry_join = ["172.16.0.2", "172.16.0.3", "172.16.0.4"]
  }
}