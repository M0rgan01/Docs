job "keycloak" {
  datacenters = ["dc1"]
  type = "service"
  group "keycloak" {
    count = 1
    task "keycloak" {
      driver = "docker"

      env {
        DB_VENDOR = "POSTGRES"
        DB_ADDR = "172.16.0.2"
        DB_DATABASE = "keycloak"
        DB_USER = "keycloak"
        DB_PASSWORD = "password"
        KEYCLOAK_USER = "admin"
        KEYCLOAK_PASSWORD = "admin"
        KEYCLOAK_LOGLEVEL = "INFO"
        ROOT_LOGLEVEL = "INFO"
      }

      config {
        image = "jboss/keycloak:12.0.1"
        port_map {
          http = 8080
        }
      }

      resources {
        cpu = 600
        memory = 600

        network {
          mbits = 10
          port "keycloak-http" {
            static = 8080
          }
        }
      }

      service {
        name = "${TASKGROUP}"
        port = "keycloak-http"
        tags = [
          "traefik.enable=true",
          "traefik.http.routers.keycloak-http.rule=PathPrefix(`/auth`)",
        ]
        check {
          name     = "alive"
          type     = "http"
          path     = "/"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}