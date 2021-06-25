data_dir  = "/var/lib/nomad"

client {
  enabled = true
  network_interface = "enp0s8"

  host_volume "postgres" {
    path = "/home/vagrant/volumes/postgres"
    read_only = false
  }
}

server {
  enabled = true
  bootstrap_expect = 1
}

acl {
  enabled = false
}

consul {
  token = "token"
}