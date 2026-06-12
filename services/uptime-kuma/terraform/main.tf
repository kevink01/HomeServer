##################################################################
## ------------------------------------------------------------ ##
## | Tags                                                     | ##
## ------------------------------------------------------------ ##
##################################################################

resource "uptimekuma_tag" "http" {
  name  = "HTTP"
  color = "#005b9c"
}

resource "uptimekuma_tag" "ping" {
  name  = "ping"
  color = "#000000"
}

resource "uptimekuma_tag" "postgresql" {
  name  = "PostgreSQL"
  color = "#2f6792"
}

resource "uptimekuma_tag" "docker" {
  name  = "Docker"
  color = "#2597ee"
}

resource "uptimekuma_tag" "critical" {
  name  = "Critical"
  color = "#ad0909"
}

resource "uptimekuma_tag" "networking" {
  name  = "Networking"
  color = "#128a3a"
}

resource "uptimekuma_tag" "media" {
  name  = "Media"
  color = "#18c249"
}

resource "uptimekuma_tag" "tools" {
  name  = "Tools"
  color = "#cc8f0c"
}

resource "uptimekuma_tag" "cicd" {
  name  = "CI/CD"
  color = "#47097a"
}

##################################################################
## ------------------------------------------------------------ ##
## | Notifications                                            | ##
## ------------------------------------------------------------ ##
##################################################################

resource "uptimekuma_notification_discord" "discord_notification" {
  name        = "Discord Alerts"
  webhook_url = var.discord_webhook
  username    = "Uptime Kuma"
  disable_url = false
  is_active   = true
  is_default  = true
}

##################################################################
## ------------------------------------------------------------ ##
## | Monitor Groups                                           | ##
## ------------------------------------------------------------ ##
##################################################################

resource "uptimekuma_monitor_group" "network" {
  name = "Network"
  tags = [
    {
      tag_id = uptimekuma_tag.critical.id
    }
  ]
}

resource "uptimekuma_monitor_group" "cicd" {
  name = "CI/CD"
  tags = [
    {
      tag_id = uptimekuma_tag.cicd.id
    }
  ]
}

resource "uptimekuma_monitor_group" "media" {
  name = "Media"
  tags = [
    {
      tag_id = uptimekuma_tag.media.id
    }
  ]
}

resource "uptimekuma_monitor_group" "tools" {
  name = "Tools"
  tags = [
    {
      tag_id = uptimekuma_tag.tools.id
    }
  ]
}

##################################################################
## ------------------------------------------------------------ ##
## | Monitors                                                 | ##
## ------------------------------------------------------------ ##
##################################################################

resource "uptimekuma_monitor_ping" "gitlab" {
  name             = "GitLab"
  hostname         = "www.gitlab.kkulich.dev"
  interval         = 60
  timeout          = 30
  max_retries      = 2
  retry_interval   = 60
  packet_size      = 56
  notification_ids = [uptimekuma_notification_discord.discord_notification.id]
  parent           = uptimekuma_monitor_group.cicd.id
  tags = [
    {
      tag_id : uptimekuma_tag.cicd.id
    }
  ]
}

##################################################################
## ------------------------------------------------------------ ##
## | Docker Host                                              | ##
## ------------------------------------------------------------ ##
##################################################################

resource "uptimekuma_docker_host" "docker_default_host" {
  name          = "Docker Host"
  docker_daemon = "/var/run/docker.sock"
  docker_type   = "socket"
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
          id       = uptimekuma_monitor_ping.gitlab.id
          send_url = true
        }
      ]
    }
  ]
}
