job "node-exporter" {
  datacenters = ["dc1"]
  type        = "service"

  group "node-exporter" {
    count = 1

    network {
      port "http" {
        static = 9100
      }
    }

    restart {
      attempts = 3
      delay    = "20s"
      mode     = "delay"
    }

    task "node-exporter" {
      driver = "docker"

      config {
        image = "prom/node-exporter:latest"
        ports = ["http"]
      }

      resources {
        cpu    = 200
        memory = 200
      }

      service {
        name = "node-exporter"
        port = "http"
        tags = ["monitoring","prometheus"]

        check {
          name     = "Node-exporter HTTP"
          type     = "http"
          path     = "/health"
          interval = "5s"
          timeout  = "2s"

          check_restart {
            limit           = 2
            grace           = "60s"
            ignore_warnings = false
          }
        }
      }
    }
  }
}