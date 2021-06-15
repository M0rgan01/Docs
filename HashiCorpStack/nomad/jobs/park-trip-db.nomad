job "park-trip-db" {
  datacenters = ["dc1"]

  group "park-trip-db" {
    count = 1
    network {
      port "park-trip-db" {
        to = 5432
        static = 5432
      }
    }
    task "park-trip-db" {
      driver = "docker"

      env {
        POSTGRES_MULTIPLE_DATABASES = "park_trip, keycloak"
        POSTGRES_USER = "admin"
        POSTGRES_PASSWORD = "password"
      }

      config {
        image = "postgres"
        ports = ["park-trip-db"]
        volumes = [
          "local/initDatabases.sh:/docker-entrypoint-initdb.d/initDatabases.sh",
        ]
      }

      template {
        data = <<EOF
#!/bin/bash

set -e
set -u

function create_user_and_database() {
	local database=$1
	echo "  Creating user and database '$database'"
	psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
	    CREATE USER $database;
	    CREATE DATABASE $database;
	    GRANT ALL PRIVILEGES ON DATABASE $database TO $database;
EOSQL
}

if [ -n "$POSTGRES_MULTIPLE_DATABASES" ]; then
	echo "Multiple database creation requested: $POSTGRES_MULTIPLE_DATABASES"
	for db in $(echo "$POSTGRES_MULTIPLE_DATABASES" | tr ',' ' '); do
		create_user_and_database $db
	done
	echo "Multiple databases created"
fi
EOF

        destination = "local/initDatabases.sh"
      }

      resources {
        cpu = 300
        memory = 300
      }

      service {
        name = "${TASKGROUP}"
        port = "park-trip-db"

        check {
          type = "tcp"
          interval = "10s"
          timeout = "2s"
        }
      }
    }
  }
}