job "park-trip-traefik" {

  region      = "global"
  datacenters = ["dc1"]
  type        = "service"

  group "park-trip-traefik" {
    count = 1

    network {

      port "traefik-http" {
        static = 80
      }

      port "api" {
        static = 8081
      }
    }

    task "park-trip-traefik" {
      driver = "docker"

      config {
        image        = "traefik:v2.2"
        network_mode = "host"

        volumes = [
          "local/traefik.yml:/etc/traefik/traefik.yml",
        ]
      }

      template {
        data = <<EOF
log:
  level: INFO

api:
  insecure: true
  dashboard: true

providers:
  consulCatalog:
    exposedByDefault: false
    prefix: traefik

    endpoint:
      address: 127.0.0.1:8500
      scheme: http

entryPoints:
  web:
    address: :80

  traefik:
    address: :8081

  websecure:
    address: :443

# PROCESS let's encrytp https://www.grottedubarbu.fr/traefik-dns-challenge-ovh/
# https://doc.traefik.io/traefik/user-guides/docker-compose/acme-dns/

certificatesResolvers:
  myresolver:
    acme:
      caServer: https://acme-staging-v02.api.letsencrypt.org/directory
      email: pichat.morgan@gmail.com
      # chmod 600 acme.json -> sur une nouvelle install
      storage: "/etc/traefik/acme.json"
      httpChallenge:
        entryPoint: web
EOF

        destination = "local/traefik.yml"
      }

      resources {
        cpu    = 100
        memory = 128
      }
    }


    service {
      name = "${TASKGROUP}"

      check {
        name     = "alive"
        type     = "tcp"
        port     = "traefik-http"
        interval = "10s"
        timeout  = "2s"
      }
    }
  }
}