##################################################################
## ------------------------------------------------------------ ##
## | Tags                                                     | ##
## ------------------------------------------------------------ ##
##################################################################

resource "uptimekuma_tag" "traefik" {
  name  = "Traefik"
  color = "#24a1c1"
}

##################################################################
## ------------------------------------------------------------ ##
## | Monitor Groups                                           | ##
## ------------------------------------------------------------ ##
##################################################################

resource "uptimekuma_monitor_group" "traefik" {
  name   = "Traefik"
  parent = var.group_network_id
  tags = [
    {
      tag_id = uptimekuma_tag.traefik.id
    },
    {
      tag_id = var.tag_critical_id
    }
  ]
}

##################################################################
## ------------------------------------------------------------ ##
## | Monitors                                                 | ##
## ------------------------------------------------------------ ##
##################################################################

resource "uptimekuma_monitor_ping" "traefik" {
  name = "Traefik (Ping)"

  hostname = var.traefik_endpoint

  interval         = 60
  timeout          = 30
  max_retries      = 2
  retry_interval   = 60
  packet_size      = 56
  notification_ids = [var.notification_discord]
  parent           = uptimekuma_monitor_group.traefik.id
  tags = [
    {
      tag_id = uptimekuma_tag.traefik.id
    },
    {
      tag_id = var.tag_ping_id
    },
    {
      tag_id : var.tag_critical_id
    }
  ]
}

resource "uptimekuma_monitor_http" "traefik" {
  name     = "Traefik (HTTP)"
  url      = "https://${var.traefik_endpoint}"
  interval = 60
  timeout  = 10
  active   = true
  parent   = uptimekuma_monitor_group.traefik.id
  tags = [
    {
      tag_id = uptimekuma_tag.traefik.id
    },
    {
      tag_id = var.tag_http_id
    },
    {
      tag_id : var.tag_critical_id
    }
  ]
}
