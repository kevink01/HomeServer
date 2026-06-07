##################################################################
## ------------------------------------------------------------ ##
## | Uptime Kuma Terraform Module                             | ##
## ------------------------------------------------------------ ##
##################################################################

# -------------------------------------------------------------- #
# | Tags                                                       | #
# -------------------------------------------------------------- #

resource "uptimekuma_tag" "production" {
  name  = "production"
  color = "#034efc"
}

resource "uptimekuma_tag" "staging" {
  name  = "staging"
  color = "#128a3a"
}

resource "uptimekuma_tag" "critical" {
  name  = "critical"
  color = "#ad0909"
}

resource "uptimekuma_tag" "monitoring" {
  name  = "monitoring"
  color = "#cc8f0c"
}

resource "uptimekuma_tag" "cicd" {
  name  = "CI/CD"
  color = "#47097a"
}

# -------------------------------------------------------------- #
# | Notifications                                              | #
# -------------------------------------------------------------- #

resource "uptimekuma_notification_discord" "discord_notification" {
  name        = "Discord Alerts"
  webhook_url = "https://discord.com/api/webhooks/1512843400305705022/qeW73fWW2-fu0hlqixb6xxeTNcj0Evit2bo3koq_UXFCgjQqEcGh1ErsNIWn39uI1qRC"
  username    = "Uptime Kuma"
  disable_url = false
  is_active   = true
  is_default  = true
}

# -------------------------------------------------------------- #
# | Monitor Groups                                             | #
# -------------------------------------------------------------- #
resource "uptimekuma_monitor_group" "network" {
  name = "Networking services"
  tags = [
    {
      tag_id = uptimekuma_tag.production.id
    },
    {
      tag_id = uptimekuma_tag.critical.id
    }
  ]
}

resource "uptimekuma_monitor_group" "cicd" {
  name = "CI/CD"
  tags = [
    {
      tag_id = uptimekuma_tag.production.id
    },
    {
      tag_id = uptimekuma_tag.cicd.id
    }
  ]
}

resource "uptimekuma_monitor_group" "tools" {
  name = "Tools"
  tags = [
    {
      tag_id = uptimekuma_tag.production.id
    }
  ]
}

# -------------------------------------------------------------- #
# | Monitors                                                   | #
# -------------------------------------------------------------- #

resource "uptimekuma_monitor_ping" "traefik" {
  name = "Traefik"

  #Hostname: Target hostname or IP address (string, required for ping/port monitors)
  hostname = "www.traefik.kkulich.dev"

  interval         = 60
  timeout          = 30
  max_retries      = 2
  retry_interval   = 60
  packet_size      = 56
  notification_ids = [uptimekuma_notification_discord.discord_notification.id]
  parent           = uptimekuma_monitor_group.network.id
  tags = [
    {
      tag_id : uptimekuma_tag.production.id
    },
    {
      tag_id : uptimekuma_tag.critical.id
    }
  ]
}

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
      tag_id : uptimekuma_tag.production.id
    },
    {
      tag_id : uptimekuma_tag.cicd.id
    }
  ]
}

resource "uptimekuma_monitor_ping" "homepage" {
  name = "Homepage"

  #Hostname: Target hostname or IP address (string, required for ping/port monitors)
  hostname = "www.homepage.kkulich.dev"

  interval         = 60
  timeout          = 30
  max_retries      = 2
  retry_interval   = 60
  packet_size      = 56
  notification_ids = [uptimekuma_notification_discord.discord_notification.id]
  parent           = uptimekuma_monitor_group.tools.id
  tags = [
    {
      tag_id : uptimekuma_tag.production.id
    },
    {
      tag_id : uptimekuma_tag.monitoring.id
    }
  ]
}

# -------------------------------------------------------------- #
# | Status Page                                                | #
# -------------------------------------------------------------- #

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
          id       = uptimekuma_monitor_ping.traefik.id
          send_url = true
        },
        {
          id       = uptimekuma_monitor_ping.gitlab.id
          send_url = true
        }
      ]
    }
  ]
}
