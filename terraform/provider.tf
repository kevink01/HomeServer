provider "uptimekuma" {
  endpoint = var.uptime_kuma_endpoint
  username = var.uptime_kuma_username
  password = var.uptime_kuma_password
  timeout = "2m"
  max_retries = 20
  per_attempt_timeout = "5s"
}
