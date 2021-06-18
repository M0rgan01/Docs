data_dir  = "/var/lib/nomad"
client {
  host_volume "postgres" {
    path = "/home/vagrant/volumes/postgres"
    read_only = false
  }
}

client {
  enabled = true
  network_interface = "enp0s8"
}

server {
  enabled = true
  bootstrap_expect = 1
}

acl {
  enabled = true
}