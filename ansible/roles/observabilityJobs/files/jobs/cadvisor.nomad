job "cadvisor" {
  datacenters = ["dc1"]
  type        = "service"

  group "cadvisor" {
    count = 1

    network {
      port "http" {
        static = 8080
      }
    }

    restart {
      attempts = 3
      delay    = "20s"
      mode     = "delay"
    }

    task "cadvisor" {
      driver = "docker"

      config {
        image = "google/cadvisor:latest"
        ports = ["http"]

        volumes = [
          "/:/rootfs:ro",
          "/var/run:/var/run:rw",
          "/sys:/sys:ro",
         " /var/lib/docker/:/var/lib/docker:ro"
        ]
      }

      resources {
        cpu    = 200
        memory = 200
      }

      service {
        name = "cadvisor"
        port = "http"
        tags = ["monitoring","prometheus"]

        check {
          name     = "Cadvisor HTTP"
          type     = "http"
          path     = "/"
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