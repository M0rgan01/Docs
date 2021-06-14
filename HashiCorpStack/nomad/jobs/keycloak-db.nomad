job "keycloak-db" {
  datacenters = ["dc1"]

  group "keycloak-db" {
    count = 1
    task "keycloak-db" {
      driver = "docker"

      env {
        POSTGRES_DB = "keycloak"
        POSTGRES_USER = "keycloak"
        POSTGRES_PASSWORD = "password"
      }

      config {
        image = "postgres"

        port_map {
          db = 5432
        }
      }

      resources {
        cpu = 300
        memory = 300

        network {
          port "db" {
            static = 5432
          }
        }
      }

      service {
        name = "keycloak-db"
        port = "db"

        check {
          type = "tcp"
          interval = "10s"
          timeout = "2s"
        }
      }
    }
  }
}