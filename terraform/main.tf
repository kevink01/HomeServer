module "uptime-kuma" {
  source               = "../services/uptime-kuma/terraform"
  uptime_kuma_endpoint = var.uptime_kuma_endpoint
  uptime_kuma_username = var.uptime_kuma_username
  uptime_kuma_password = var.uptime_kuma_password
}
