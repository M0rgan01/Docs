job "keycloak" {
  datacenters = ["dc1"]
  type = "service"
  group "keycloak" {
    count = 1

    restart {
      // nombre max de restart
      attempts = 5
      // attente pour le redémarrage d'une tache
      delay    = "15s"
      interval = "30m"
      mode     = "fail"
    }

    network {
      port "keycloak-http" {
        to = 8080
        static = 8080
      }
    }

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
        ports = ["keycloak-http"]
      }

      resources {
        cpu = 600
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