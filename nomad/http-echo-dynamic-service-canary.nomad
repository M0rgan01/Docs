job "http-echo" {
  datacenters = ["dc1"]

  group "echo" {
    count = 5
    update {
      canary        = 1
      max_parallel  = 5
    }
    task "server" {
      driver = "docker"

      config {
        image = "hashicorp/http-echo:latest"
        args = [
          "-listen", ":${NOMAD_PORT_http}",
          "-text", "Update ! Hello and welcome to ${NOMAD_IP_http} running on port ${NOMAD_PORT_http}",
        ]
      }

      resources {
        network {
          mbits = 10
          port "http" {}
        }
      }

      service {
        name = "http-echo"
        port = "http"

        tags = [
          "traefik.enable=true",
          "traefik.http.routers.http.rule=Host(`test.localhost`) && Path(`/myapp`)",
        ]

        check {
          type      = "http"
          path      = "/health"
          interval  = "2s"
          timeout   = "2s"
        }
      }
    }
  }
}