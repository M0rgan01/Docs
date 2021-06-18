job "park-trip-api" {

  datacenters = ["dc1"]

  // Il existe trois type
  // - Batch -> Conçu pour des taches de courte durée, se terminant en quelques minutes à quelques jours.
  // - Service -> Conçu pour planifier des services de longue durée.
  // - System -> Exécuté unitairement sur l'ensemble des clients, également lorsqu'un client rejoint le cluster. Utile si l'on
  // désire que le Job soit réparti sur l'ensemble des clients du cluster
  type = "service"

  update {
    max_parallel      = 3
    health_check      = "checks"
    min_healthy_time  = "10s"
    healthy_deadline  = "5m"
    progress_deadline = "10m"
    auto_revert       = true
    auto_promote      = true
    canary            = 1
    stagger           = "30s"
  }

  group "park-trip-api" {
    count = 1

    // politique de redémarrage de l'allocation d'un job
    restart {
      // Interval comptabilisant le nombre de redémarrage
      interval = "30m"
      // maximum de redémarrage d'un job
      attempts = 2
      // Attente avant le prochain redémarrage
      delay    = "15s"
      mode     = "fail"
    }

    // politique de replanification d'un job -> maximum de redémarrage atteint
    reschedule {
      delay          = "30s"
      delay_function = "exponential"
      max_delay      = "1h"
      unlimited      = true
    }

    network {
      port "api-http" {
        // pointe le port dans le service à mappé
        to = 8090
        // pointe le port dans le host à mappé (dynamique par défaut)
        static = 8090
      }
    }

    // charge individuel de travail, comme un conteneur docker, une app java...
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

      // nomad autoscaling stanza
      scaling {
        enabled = true
        min = 0
        max = 10
        policy {
        }
      }

      // téléchargement d'artéfact
      artifact {
        source      = "https://example.com/file.yml.tpl"
        destination = "local/file.yml.tpl"
      }

      // ajoute des données dans le répertoire du job
      template {
        source      = "local/file.yml.tpl"
        destination = "local/file.yml"
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