module "uptime-kuma" {
  source                   = "../services/uptime-kuma/terraform"
  uptime_kuma_endpoint     = var.uptime_kuma_endpoint
  uptime_kuma_username     = var.uptime_kuma_username
  uptime_kuma_password     = var.uptime_kuma_password
  discord_ping_webhook     = var.discord_ping_webhook
  discord_docker_webhook   = var.discord_docker_webhook
  discord_postgres_webhook = var.discord_postgres_webhook
  discord_traefik_webhook  = var.discord_traefik_webhook
}

module "code_server" {
  source               = "../services/code-server/terraform"
  code_server_endpoint = var.code_server_endpoint
  tag_ping_id          = module.uptime-kuma.tag_ping_id
  tag_http_id          = module.uptime-kuma.tag_http_id
  group_tools_id       = module.uptime-kuma.group_tools_id
  discord_ping_webhook     = module.uptime-kuma.ping_discord_webhook
  discord_docker_webhook   = module.uptime-kuma.docker_discord_webhook
  discord_traefik_webhook  = module.uptime-kuma.traefik_discord_webhook
}

module "forgejo" {
  source                    = "../services/forgejo/terraform"
  forgejo_endpoint          = var.forgejo_endpoint
  docker_default_host       = module.uptime-kuma.docker_default_host_id
  tag_ping_id               = module.uptime-kuma.tag_ping_id
  tag_http_id               = module.uptime-kuma.tag_http_id
  tag_postgresql_id         = module.uptime-kuma.tag_postgresql_id
  tag_docker_id             = module.uptime-kuma.tag_docker_id
  tag_cicd_id               = module.uptime-kuma.tag_cicd_id
  group_cicd_id             = module.uptime-kuma.group_cicd_id
  discord_ping_webhook     = module.uptime-kuma.ping_discord_webhook
  discord_docker_webhook   = module.uptime-kuma.docker_discord_webhook
  discord_postgres_webhook = module.uptime-kuma.postgres_discord_webhook
  discord_traefik_webhook  = module.uptime-kuma.traefik_discord_webhook
  forgejo_database_hostname = var.forgejo_database_hostname
  forgejo_database_port     = var.forgejo_database_port
  forgejo_database_user     = var.forgejo_database_user
  forgejo_database_password = var.forgejo_database_password
  forgejo_database_name     = var.forgejo_database_name
}

module "homepage" {
  source               = "../services/homepage/terraform"
  homepage_endpoint    = var.homepage_endpoint
  tag_ping_id          = module.uptime-kuma.tag_ping_id
  tag_http_id          = module.uptime-kuma.tag_http_id
  tag_docker_id        = module.uptime-kuma.tag_docker_id
  group_tools_id       = module.uptime-kuma.group_tools_id
  discord_ping_webhook     = module.uptime-kuma.ping_discord_webhook
  discord_docker_webhook   = module.uptime-kuma.docker_discord_webhook
  discord_traefik_webhook  = module.uptime-kuma.traefik_discord_webhook
  docker_default_host  = module.uptime-kuma.docker_default_host_id
}

module "immich" {
  source                    = "../services/immich/terraform"
  immich_endpoint           = var.immich_endpoint
  docker_default_host       = module.uptime-kuma.docker_default_host_id
  tag_ping_id               = module.uptime-kuma.tag_ping_id
  tag_http_id               = module.uptime-kuma.tag_http_id
  tag_postgresql_id         = module.uptime-kuma.tag_postgresql_id
  tag_docker_id             = module.uptime-kuma.tag_docker_id
  tag_media_id               = module.uptime-kuma.tag_media_id
  group_media_id             = module.uptime-kuma.group_media_id
  discord_ping_webhook     = module.uptime-kuma.ping_discord_webhook
  discord_docker_webhook   = module.uptime-kuma.docker_discord_webhook
  discord_postgres_webhook = module.uptime-kuma.postgres_discord_webhook
  discord_traefik_webhook  = module.uptime-kuma.traefik_discord_webhook
  immich_database_hostname = var.immich_database_hostname
  immich_database_port     = var.immich_database_port
  immich_database_user     = var.immich_database_user
  immich_database_password = var.immich_database_password
  immich_database_name     = var.immich_database_name
}

module "traefik" {
  source               = "../services/traefik/terraform"
  traefik_endpoint     = var.traefik_endpoint
  tag_ping_id          = module.uptime-kuma.tag_ping_id
  tag_http_id          = module.uptime-kuma.tag_http_id
  tag_critical_id      = module.uptime-kuma.tag_critical_id
  group_network_id     = module.uptime-kuma.group_network_id
  discord_ping_webhook     = module.uptime-kuma.ping_discord_webhook
  discord_docker_webhook   = module.uptime-kuma.docker_discord_webhook
  discord_traefik_webhook  = module.uptime-kuma.traefik_discord_webhook
}

##################################################################
## ------------------------------------------------------------ ##
## | Status Page                                              | ##
## ------------------------------------------------------------ ##
##################################################################

resource "uptimekuma_status_page" "home_status_page" {
  slug                    = "home"
  title                   = "All Services Status Page"
  description             = "Status page for all production services"
  published               = true
  theme                   = "dark"
  show_certificate_expiry = true
  show_tags               = true
  public_group_list = [
    {
      name   = "Production Services"
      weight = 1
      monitor_list = [
        {
          id       = module.code_server.code_server_group
          send_url = true
        },
        {
          id       = module.forgejo.forgejo_group
          send_url = true
        },
        {
          id       = module.homepage.homepage_group
          send_url = true
        },
        {
          id       = module.immich.immich_group
          send_url = true
        },
        {
          id       = module.traefik.traefik_group
          send_url = true
        }
      ]
    }
  ]
}