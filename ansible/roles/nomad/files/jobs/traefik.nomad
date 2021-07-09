job "traefik" {

  region      = "global"
  datacenters = ["dc1"]
  type        = "system"

  group "traefik" {

    network {

      port "http" {
        static = 80
      }

      port "api" {
        static = 8081
      }
    }

    task "traefik" {
      driver = "docker"

      config {
        image        = "traefik:v2.2"
        network_mode = "host"
        volumes = ["local/traefik.toml:/etc/traefik/traefik.toml"]
      }

      template {
        data = <<EOF
[entryPoints]
    [entryPoints.http]
    address = ":80"
    [entryPoints.traefik]
    address = ":8081"

[api]
    dashboard = true
    insecure  = true

# Enable Consul Catalog configuration backend.
[providers.consulCatalog]
    prefix           = "traefik"
    exposedByDefault = false

    [providers.consulCatalog.endpoint]
      address = "{{ env "CONSUL_HTTP_ADDR" }}"
      scheme  = "http"
EOF

        destination = "local/traefik.toml"
      }

      resources {
        cpu    = 100
        memory = 128
      }
    }


    service {
      name = "${TASKGROUP}"

      check {
        name     = "alive"
        type     = "tcp"
        port     = "http"
        interval = "10s"
        timeout  = "2s"
      }
    }
  }
}