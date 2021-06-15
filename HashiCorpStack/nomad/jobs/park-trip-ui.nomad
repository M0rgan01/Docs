job "park-trip-ui" {
  datacenters = ["dc1"]
  type = "service"
  group "park-trip-ui" {
    count = 1

    network {
      port "ui-http" {
        to = 80
      }
    }

    task "park-trip-ui" {
      driver = "docker"

      env {
        VUE_APP_API_URL = "http://172.16.0.2"
        VUE_APP_KEYCLOAK_CLIENT_ID = "Park-trip-ui"
        VUE_APP_KEYCLOAK_REALM = "park-trip"
        VUE_APP_KEYCLOAK_AUTH_URL = "http://172.16.0.2/auth/"
        VUE_APP_KEYCLOAK_REDIRECT_URL = "http://172.16.0.2"
        VUE_APP_KEYCLOAK_SILENT_SSO_FILE_NAME = "silentSSO.html"
      }

      config {
        image = "ghcr.io/m0rgan01/park-trip/park-trip-ui:master"
        ports = ["ui-http"]
        auth {
          username = "M0rgan01"
          password = ""
        }
      }

      resources {
        cpu = 400
        memory = 300
      }

      service {
        name = "${TASKGROUP}"
        port = "ui-http"
        tags = [
          "traefik.enable=true",
          "traefik.http.routers.ui-http.rule=PathPrefix(`/`)",
        ]
      }
    }
  }
}