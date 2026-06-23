##################################################################
## ------------------------------------------------------------ ##
## | Tags                                                     | ##
## ------------------------------------------------------------ ##
##################################################################

resource "uptimekuma_tag" "immich" {
  name  = "Immich"
  color = "#18c249"
}

##################################################################
## ------------------------------------------------------------ ##
## | Monitors Groups                                          | ##
## ------------------------------------------------------------ ##
##################################################################

resource "uptimekuma_monitor_group" "immich" {
  name   = "Immich"
  parent = var.group_media_id
  tags = [
    {
      tag_id = var.tag_media_id
    },
    {
      tag_id = uptimekuma_tag.immich.id
    }
  ]
}

resource "uptimekuma_monitor_group" "immich_webui" {
  name   = "Immich (Web)"
  parent = uptimekuma_monitor_group.immich.id
  tags = [
    {
      tag_id = var.tag_media_id
    },
    {
      tag_id = uptimekuma_tag.immich.id
    }
  ]
}

resource "uptimekuma_monitor_group" "immich_db" {
  name   = "Immich (PostgreSQL)"
  parent = uptimekuma_monitor_group.immich.id
  tags = [
    {
      tag_id = var.tag_media_id
    },
    {
      tag_id = uptimekuma_tag.immich.id
    }
  ]
}

# ============================================================== #
# -------------------------------------------------------------- #
# | Monitors                                                   | #
# -------------------------------------------------------------- #
# ============================================================== #

# -------------------------------------------------------------- #
# | Immich  WebUI                                              | #
# -------------------------------------------------------------- #

resource "uptimekuma_monitor_ping" "immich" {
  name = "Immich (Ping)"

  hostname = var.immich_endpoint

  interval         = 60
  timeout          = 30
  max_retries      = 2
  retry_interval   = 60
  packet_size      = 56
  notification_ids = [var.discord_ping_webhook]
  parent           = uptimekuma_monitor_group.immich_webui.id
  tags = [
    {
      tag_id = var.tag_media_id
    },
    {
      tag_id = uptimekuma_tag.immich.id
    },
    {
      tag_id = var.tag_ping_id
    }
  ]
}

resource "uptimekuma_monitor_http" "immich" {
  name             = "Immich (HTTP)"
  url              = "https://${var.immich_endpoint}"
  interval         = 60
  timeout          = 10
  active           = true
  notification_ids = [var.discord_traefik_webhook]
  parent           = uptimekuma_monitor_group.immich_webui.id
  tags = [
    {
      tag_id = var.tag_media_id
    },
    {
      tag_id = uptimekuma_tag.immich.id
    },
    {
      tag_id = var.tag_http_id
    }
  ]
}

resource "uptimekuma_monitor_docker" "immich" {
  name             = "Immich (Docker)"
  description      = "Monitor Immich docker container"
  docker_host_id   = var.docker_default_host
  docker_container = "immich_ui"
  interval         = 60
  max_retries      = 2
  notification_ids = [var.discord_docker_webhook]
  parent           = uptimekuma_monitor_group.immich_webui.id
  tags = [
    {
      tag_id = var.tag_media_id
    },
    {
      tag_id = uptimekuma_tag.immich.id
    },
    {
      tag_id = var.tag_docker_id
    }
  ]
}

# -------------------------------------------------------------- #
# | Immich PostgreSQL                                          | #
# -------------------------------------------------------------- #

resource "uptimekuma_monitor_postgres" "immich" {
  name                       = "Immich (PostgreSQL)"
  database_connection_string = "postgres://${var.immich_database_user}:${var.immich_database_password}@${var.immich_database_hostname}:${var.immich_database_port}/${var.immich_database_name}"
  database_query             = "SELECT 1"
  interval                   = 300
  retry_interval             = 60
  max_retries                = 2
  active                     = true
  notification_ids           = [var.discord_postgres_webhook]
  parent                     = uptimekuma_monitor_group.immich_db.id
  tags = [
    {
      tag_id = var.tag_media_id
    },
    {
      tag_id = uptimekuma_tag.immich.id
    },
    {
      tag_id = var.tag_postgresql_id
    }
  ]
}

resource "uptimekuma_monitor_docker" "immich_postgres" {
  name             = "Immich PostgreSQL (Docker)"
  description      = "Monitor Immich PostgreSQL docker container"
  docker_host_id   = var.docker_default_host
  docker_container = "immich_postgres"
  interval         = 60
  max_retries      = 2
  notification_ids = [var.discord_docker_webhook]
  parent           = uptimekuma_monitor_group.immich_db.id
  tags = [
    {
      tag_id = var.tag_media_id
    },
    {
      tag_id = uptimekuma_tag.immich.id
    },
    {
      tag_id = var.tag_docker_id
    }
  ]
}

# # -------------------------------------------------------------- #
# # | Immich Redis                                               | #
# # -------------------------------------------------------------- #

# resource "uptimekuma_monitor_docker" "forgejo_runner" {
#   name             = "Forgejo Runner"
#   description      = "Monitor Forgejo CI/CD runner"
#   docker_host_id   = var.docker_default_host
#   docker_container = "forgejo-runner"
#   interval         = 60
#   max_retries      = 2
#   notification_ids = [var.notification_discord]
#   parent           = uptimekuma_monitor_group.immich.id
#   tags = [
#     {
#       tag_id = var.tag_media_id
#     },
#     {
#       tag_id = tuptimekuma_tag.immich.id
#     },
#     {
#       tag_id = var.tag_docker_id
#     }
#   ]
# }

# # -------------------------------------------------------------- #
# # | Forgejo Runners                                            | #
# # -------------------------------------------------------------- #

# resource "uptimekuma_monitor_docker" "forgejo_dind" {
#   name             = "Forgejo Docker-in-Docker"
#   description      = "Monitor Forgejo DinD service"
#   docker_host_id   = var.docker_default_host
#   docker_container = "forgejo-dind"
#   interval         = 60
#   max_retries      = 2
#   notification_ids = [var.notification_discord]
#   parent           = uptimekuma_monitor_group.immich.id
#   tags = [
#     {
#       tag_id = var.tag_media_id
#     },
#     {
#       tag_id = tuptimekuma_tag.immich.id
#     },
#     {
#       tag_id = var.tag_docker_id
#     }
#   ]
# }
