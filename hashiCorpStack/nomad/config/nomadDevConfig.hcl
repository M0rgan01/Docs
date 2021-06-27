data_dir = "/var/lib/nomad"

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

vault {
  enabled = true
  address = "http://172.16.0.2:8200"
  token = "SQQHkK672aXEoxmDJU5lSu7H"
}