data_dir  = "/var/lib/nomad"

client {
  enabled = true
  network_interface = "enp0s8"
  server_join {
    retry_join = ["172.16.0.2"]
  }
}