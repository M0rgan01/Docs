// https://www.nomadproject.io/docs/job-specification

job "park-trip-api" {

  datacenters = ["dc1"]

  // défini l'environnement par un namespace existant -> 'default' par défaut
  // (nomad namespace list / nomad namespace apply -description "QA instances of webservers" web-qa)
  namespace = "web-qa"

  // Il existe trois type de job
  // - BATCH -> Conçu pour des taches de courte durée, se terminant en quelques minutes à quelques jours.
  // - SERVICE -> Conçu pour planifier des services de longue durée.
  // - SYSTEM -> Exécuté unitairement sur l'ensemble des clients, également lorsqu'un client rejoint le cluster. Utile si l'on
  // désire que le Job soit réparti sur l'ensemble des clients du cluster
  type = "service"

  // uniquement pour les batchs
  periodic {
    // Voir https://github.com/hashicorp/cronexpr#implementation pour les helpers
    // cron = "@daily"
    cron = "*/15 * * * * *"
    // spécifie si le job doit attendre la fin des instances précédentes pour se lancer
    prohibit_overlap = true
    time_zone = "America/New_York"
  }

  // Politique de mise à jour du job
  update {
    // nombre d'allocations au sein d'un groupe de tâches qui peuvent être mises à jour en même temps. défaut -> 1
    max_parallel = 3
    // détermine la vérification, içi le check utilisé dans le service
    health_check = "checks"
    min_healthy_time = "10s"
    healthy_deadline = "5m"
    progress_deadline = "10m"
    // revient à l'ancienne version si le déploiement à échoué, false par défaut
    auto_revert = true
    // spécifie si un déploiement canary réussi (par vérification health_check) doit
    // promouvoir les autres automatiquement, false par défaut
    auto_promote = true
    // permet d'avoir des allocations de 'test' sur une partie de celles en cours
    canary = 1
    stagger = "30s"
  }

  // un groupe de tâches
  group "park-trip-api" {
    count = 1

    // politique de redémarrage de l'allocation d'un job
    restart {
      // Interval comptabilisant le nombre de redémarrage
      interval = "30m"
      // maximum de redémarrage d'un job
      attempts = 2
      // Attente avant le prochain redémarrage
      delay = "15s"
      mode = "fail"
    }

    // politique de replanification d'un job -> maximum de redémarrage atteint
    reschedule {
      delay = "30s"
      delay_function = "exponential"
      max_delay = "1h"
      unlimited = true
    }

    network {
      mode= "host"
      port "api-http" {
        // pointe le port dans le service à mappé
        to = 8090
        // pointe le port dans le host à mappé (dynamique par défaut)
        static = 8090
        // port uniquement exposé à un réseau 'public' ou 'private'
        host_network = "private"
      }
    }

    // charge individuel de travail, comme un conteneur docker, une app java...
    task "park-trip-api" {

      // les principaux driver:
      // - DOCKER
      // - JAVA
      // - EXEC -> utilisé pour exécuter simplement une commande particulière pour une tâche.
      //   utilise les primitives d'isolation sous-jacentes du système d'exploitation pour limiter
      //   l'accès de la tâche aux ressources.
      // - RAW-EXEC -> utilisé pour exécuter une commande pour une tâche sans aucune isolation.
      //   De plus, la tâche est démarrée avec le même utilisateur que le processus Nomad.
      //   (désactiver par défaut, à utiliser avec précaution)
      driver = "docker"


      // variable d'environnment
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
        // utilisation des stratégies de ports ciblées dans la partie network
        ports = ["api-http"]
        // commande par défaut
        command = "my-command"
        // arguments de la commande exécutée
        args = [
          "-bind", "${NOMAD_PORT_http}",
          "${nomad.datacenter}",
          "${MY_ENV}",
          "${meta.foo}",
        ]
        auth {
          username = "M0rgan01"
          password = ""
        }
        volumes = [
          "host:container",
        ]
      }

      // ressource max de la tache
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
        source = "https://example.com/file.yml.tpl"
        destination = "local/file.yml.tpl"
      }

      // ajoute des données dans le répertoire du job
      template {
        source = "local/file.yml.tpl"
        destination = "local/file.yml"
      }

      // consul service definition
      service {
        name = "${TASKGROUP}"
        // nom du port à écouté
        port = "api-http"
        tags = [
          "traefik.enable=true",
          "traefik.http.routers.api-http.rule=PathPrefix(`/api`)",
        ]

        // health check
        check {
          type = "tcp"
          // nom du port à écouté (celui du service par défaut)
          port = "api-http"
          interval = "10s"
          timeout = "2s"

          check_restart {
            limit = 3
            grace = "90s"
            ignore_warnings = false
          }
        }

        // consul connect (sans besoin de connection), nécessite network bridge
        connect {
          sidecar_service {}
        }

        // consul connect (avec besoin de connection), nécessite network bridge
        connect {
          sidecar_service {
            proxy {
              upstreams {
                // nom du service de destination
                destination_name = "count-api"
                // port de la tache à écouter
                local_bind_port = 8080

                // pour faire référence au service -> "http://${NOMAD_UPSTREAM_ADDR_count_api}"
              }
            }
          }
        }
      }
    }
  }
}