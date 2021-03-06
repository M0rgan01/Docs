job "http-echo" {
  datacenters = ["dc1"]

  group "echo" {
    count = 3

    network {
      port "http" {}
    }

    task "server" {
      driver = "docker"

      config {
        image = "hashicorp/http-echo:latest"
        ports = ["http"]
        args = [
          "-listen", ":${NOMAD_PORT_http}",
          "-text", "Hello and welcome to ${NOMAD_IP_http} running on port ${NOMAD_PORT_http}",
        ]
      }

      service {
        name = "http-echo"
        port = "http"

        tags = [
          "traefik.enable=true",
          "traefik.http.routers.http.rule=Path(`/myapp`)",
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