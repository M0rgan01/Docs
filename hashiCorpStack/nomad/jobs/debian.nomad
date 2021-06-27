job "debian" {
  datacenters = ["dc1"]

  group "debian" {
    count = 1
    task "debian" {
      driver = "docker"

      config {
        image = "debian:9"
        command = "/bin/bash"
        interactive = true
        tty = true
      }

      template {

        data = <<EOH
        TEST_ENV="{{key "test-env"}}"
        TEST_ENV_SECRET="{{with secret "secret/test-env"}}{{.Data.data.key}}{{end}}"
        EOH

        destination = "local/file.env"
        env         = true
      }
    }
  }
}