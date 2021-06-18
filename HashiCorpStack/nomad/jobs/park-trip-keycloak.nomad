job "park-trip-keycloak" {
  datacenters = ["dc1"]
  type = "service"
  group "park-trip-keycloak" {
    count = 1

    network {
      port "keycloak-http" {
        to = 8080
      }
    }

    task "park-trip-keycloak" {
      driver = "docker"

      env {
        DB_VENDOR = "POSTGRES"
        DB_ADDR = "172.16.0.2"
        DB_DATABASE = "keycloak"
        DB_USER = "admin"
        DB_PASSWORD = "password"
        KEYCLOAK_USER = "admin"
        KEYCLOAK_PASSWORD = "admin"
        KEYCLOAK_LOGLEVEL = "INFO"
        ROOT_LOGLEVEL = "INFO"
      }

      config {
        image = "ghcr.io/m0rgan01/park-trip-authentification:master"
        ports = ["keycloak-http"]
        auth {
          username = "M0rgan01"
          password = ""
        }

      }

      resources {
        cpu = 400
        memory = 600
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