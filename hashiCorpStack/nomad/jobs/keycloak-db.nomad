job "keycloak-db" {
  datacenters = ["dc1"]

  group "keycloak-db" {
    count = 1

    network {
      port "keycloak-db" {
        to = 5432
        static = 5432
      }
    }

    task "keycloak-db" {
      driver = "docker"

      env {
        POSTGRES_DB = "keycloak"
        POSTGRES_USER = "keycloak"
        POSTGRES_PASSWORD = "password"
      }

      config {
        image = "postgres"
        ports = ["keycloak-db"]
      }

      resources {
        cpu = 300
        memory = 300
      }

      service {
        name = "${TASKGROUP}"
        port = "keycloak-db"

        check {
          type = "tcp"
          interval = "10s"
          timeout = "2s"
        }
      }
    }
  }
}