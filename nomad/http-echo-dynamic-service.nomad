job "http-echo" {
  datacenters = ["dc1"]

  group "echo" {
    count = 5
    task "server" {
      driver = "docker"

      config {
        image = "hashicorp/http-echo:latest"
        args = [
          "-listen", ":${NOMAD_PORT_http}",
          "-text", "Hello and welcome to 127.0.0.1 running on port ${NOMAD_PORT_http}",
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