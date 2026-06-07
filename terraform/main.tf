module "uptime-kuma" {
  source               = "../services/uptime-kuma/terraform"
  uptime_kuma_endpoint = var.uptime_kuma_endpoint
  uptime_kuma_username = var.uptime_kuma_username
  uptime_kuma_password = var.uptime_kuma_password
}

module "code_server" {
  source               = "../services/code-server/terraform"
  code_server_endpoint = var.code_server_endpoint
  tag_ping_id          = module.uptime-kuma.tag_ping_id
  tag_http_id          = module.uptime-kuma.tag_http_id
  group_tools_id       = module.uptime-kuma.group_tools_id
  notification_discord = module.uptime-kuma.notification_discord
}

module "forgejo" {
  source               = "../services/forgejo/terraform"
  forgejo_endpoint     = var.forgejo_endpoint
  tag_ping_id          = module.uptime-kuma.tag_ping_id
  tag_http_id          = module.uptime-kuma.tag_http_id
  group_cicd_id       = module.uptime-kuma.group_cicd_id
  notification_discord = module.uptime-kuma.notification_discord
}

module "homepage" {
  source               = "../services/homepage/terraform"
  homepage_endpoint    = var.homepage_endpoint
  tag_ping_id          = module.uptime-kuma.tag_ping_id
  tag_http_id          = module.uptime-kuma.tag_http_id
  group_tools_id       = module.uptime-kuma.group_tools_id
  notification_discord = module.uptime-kuma.notification_discord
}

module "traefik" {
  source               = "../services/traefik/terraform"
  traefik_endpoint     = var.traefik_endpoint
  tag_ping_id          = module.uptime-kuma.tag_ping_id
  tag_http_id          = module.uptime-kuma.tag_http_id
  tag_critical_id      = module.uptime-kuma.tag_critical_id
  group_network_id     = module.uptime-kuma.group_network_id
  notification_discord = module.uptime-kuma.notification_discord
}
