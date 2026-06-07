##################################################################
## ------------------------------------------------------------ ##
## | Tags                                                     | ##
## ------------------------------------------------------------ ##
##################################################################

resource "uptimekuma_tag" "code_server" {
  name  = "Code Server"
  color = "#1faef2"
}

##################################################################
## ------------------------------------------------------------ ##
## | Monitor Groups                                           | ##
## ------------------------------------------------------------ ##
##################################################################

resource "uptimekuma_monitor_group" "code_server" {
  name   = "Code Server"
  parent = var.group_tools_id
  tags = [
    {
      tag_id = uptimekuma_tag.code_server.id
    }
  ]
}

##################################################################
## ------------------------------------------------------------ ##
## | Monitors                                                 | ##
## ------------------------------------------------------------ ##
##################################################################

resource "uptimekuma_monitor_ping" "code_server" {
  name = "Code Server (Ping)"

  hostname = var.code_server_endpoint

  interval         = 60
  timeout          = 30
  max_retries      = 2
  retry_interval   = 60
  packet_size      = 56
  notification_ids = [var.notification_discord]
  parent           = uptimekuma_monitor_group.code_server.id
  tags = [
    {
      tag_id = uptimekuma_tag.code_server.id
    },
    {
      tag_id = var.tag_ping_id
    }
  ]
}

resource "uptimekuma_monitor_http" "code_server" {
  name     = "Code Server (HTTP)"
  url      = "https://${var.code_server_endpoint}"
  interval = 60
  timeout  = 10
  active   = true
  parent   = uptimekuma_monitor_group.code_server.id
  tags = [
    {
      tag_id = uptimekuma_tag.code_server.id
    },
    {
      tag_id = var.tag_http_id
    }
  ]
}
