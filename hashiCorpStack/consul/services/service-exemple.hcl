# Service à mettre dans le répertoire de conf
service {
  id = "red0"
  name = "test-import-service"
  tags = ["primary"]
  address = ""
  port = 6000
  token = "ACL-token"
  checks = [
    {
      http = "http://localhost:6000/",
      interval = "5s"
      timeout = "20s"
    }
  ]
}