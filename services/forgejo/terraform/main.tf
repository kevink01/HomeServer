# -------------------------------------------------------------- #
# | Tags                                                       | #
# -------------------------------------------------------------- #

resource "uptimekuma_tag" "forgejo" {
  name  = "Forgejo"
  color = "#ff6600"
}


# -------------------------------------------------------------- #
# | Monitor Groups                                             | #
# -------------------------------------------------------------- #

resource "uptimekuma_monitor_group" "forgejo" {
  name   = "Forgejo"
  parent = var.group_cicd_id
  tags = [
    {
      tag_id = uptimekuma_tag.forgejo.id
    }
  ]
}

resource "uptimekuma_monitor_ping" "forgejo" {
  name = "Forgejo (Ping)"

  hostname = var.forgejo_endpoint

  interval         = 60
  timeout          = 30
  max_retries      = 2
  retry_interval   = 60
  packet_size      = 56
  notification_ids = [var.notification_discord]
  parent           = uptimekuma_monitor_group.forgejo.id
  tags = [
    {
      tag_id = uptimekuma_tag.forgejo.id
    },
    {
      tag_id = var.tag_ping_id
    }
  ]
}

resource "uptimekuma_monitor_http" "forgejo" {
  name     = "Forgejo (HTTP)"
  url      = "https://${var.forgejo_endpoint}"
  interval = 60
  timeout  = 10
  active   = true
  notification_ids = [var.notification_discord]
  parent   = uptimekuma_monitor_group.forgejo.id
  tags = [
    {
      tag_id = uptimekuma_tag.forgejo.id
    },
    {
      tag_id = var.tag_http_id
    }
  ]
}
