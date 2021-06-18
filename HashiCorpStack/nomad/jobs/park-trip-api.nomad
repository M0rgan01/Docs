job "park-trip-api" {

  datacenters = ["dc1"]
  type = "service"

  group "park-trip-api" {
    count = 1

    network {
      port "api-http" {
        to = 8090
      }
    }

    task "park-trip-api" {
      driver = "docker"

      env {
        SPRING_PROFILES_ACTIVE = "e2e"
        DB_URL = "jdbc:postgresql://172.16.0.2:5432/park_trip"
        KEYCLOAK_URL = "http://172.16.0.2/auth/"
        KEYCLOAK_UI_URL = "http://172.16.0.2"
        KEYCLOAK_API_URL = "http://172.16.0.2/api"
        CORS_ORIGINS = "http://172.16.0.2"
      }

      config {
        image = "ghcr.io/m0rgan01/park-trip/park-trip-api:master"
        ports = ["api-http"]
        auth {
          username = "M0rgan01"
          password = ""
        }
      }

      resources {
        cpu = 400
        memory = 500
      }

      service {
        name = "${TASKGROUP}"
        port = "api-http"
        tags = [
          "traefik.enable=true",
          "traefik.http.routers.api-http.rule=PathPrefix(`/api`)",
        ]
      }
    }
  }
}