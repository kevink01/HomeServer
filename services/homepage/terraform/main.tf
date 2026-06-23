##################################################################
## ------------------------------------------------------------ ##
## | Tags                                                     | ##
## ------------------------------------------------------------ ##
##################################################################

resource "uptimekuma_tag" "homepage" {
  name  = "Homepage"
  color = "#0e85c8"
}


##################################################################
## ------------------------------------------------------------ ##
## | Monitors Groups                                          | ##
## ------------------------------------------------------------ ##
##################################################################


resource "uptimekuma_monitor_group" "homepage" {
  name   = "Homepage"
  parent = var.group_tools_id
  tags = [
    {
      tag_id = uptimekuma_tag.homepage.id
    }
  ]
}

# ============================================================== #
# -------------------------------------------------------------- #
# | Monitors                                                   | #
# -------------------------------------------------------------- #
# ============================================================== #

resource "uptimekuma_monitor_ping" "homepage" {
  name = "Homepage (Ping)"

  hostname = var.homepage_endpoint

  interval         = 60
  timeout          = 10
  max_retries      = 2
  retry_interval   = 60
  packet_size      = 64
  notification_ids = [var.discord_ping_webhook]
  parent           = uptimekuma_monitor_group.homepage.id
  tags = [
    {
      tag_id = uptimekuma_tag.homepage.id
    },
    {
      tag_id = var.tag_ping_id
    }
  ]
}

resource "uptimekuma_monitor_http" "homepage" {
  name     = "Homepage (HTTP)"
  url      = "https://${var.homepage_endpoint}"
  interval = 60
  timeout  = 10
  active   = true
  parent   = uptimekuma_monitor_group.homepage.id
  notification_ids = [var.discord_traefik_webhook]
  tags = [
    {
      tag_id = uptimekuma_tag.homepage.id
    },
    {
      tag_id = var.tag_http_id
    }
  ]
}

resource "uptimekuma_monitor_docker" "homepage" {
  name             = "Homepage (Docker)"
  description      = "Monitor Homepage docker container"
  docker_host_id   = var.docker_default_host
  docker_container = "homepage"
  interval         = 60
  max_retries      = 2
  notification_ids = [var.discord_docker_webhook]
  parent           = uptimekuma_monitor_group.homepage.id
  tags = [
    {
      tag_id = uptimekuma_tag.homepage.id
    },
    {
      tag_id = var.tag_docker_id
    }
  ]
}
