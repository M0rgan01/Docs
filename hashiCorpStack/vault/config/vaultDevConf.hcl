listener "tcp" {
  address = "172.16.0.2:8200"
  tls_disable = "true"
}

service_registration "consul" {
  address = "172.16.0.2:8500"
}

ui = true