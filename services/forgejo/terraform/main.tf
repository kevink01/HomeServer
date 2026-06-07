##################################################################
## ------------------------------------------------------------ ##
## | Tags                                                     | ##
## ------------------------------------------------------------ ##
##################################################################

resource "uptimekuma_tag" "forgejo" {
  name  = "Forgejo"
  color = "#ff6600"
}

##################################################################
## ------------------------------------------------------------ ##
## | Monitors Groups                                          | ##
## ------------------------------------------------------------ ##
##################################################################

resource "uptimekuma_monitor_group" "forgejo" {
  name   = "Forgejo"
  parent = var.group_cicd_id
  tags = [
    {
      tag_id = var.tag_cicd_id
    },
    {
      tag_id = uptimekuma_tag.forgejo.id
    }
  ]
}

resource "uptimekuma_monitor_group" "forgejo_webui" {
  name   = "Forgejo (Web)"
  parent = uptimekuma_monitor_group.forgejo.id
  tags = [
    {
      tag_id = var.tag_cicd_id
    },
    {
      tag_id = uptimekuma_tag.forgejo.id
    }
  ]
}

resource "uptimekuma_monitor_group" "forgejo_db" {
  name   = "Forgejo (PostgreSQL)"
  parent = uptimekuma_monitor_group.forgejo.id
  tags = [
    {
      tag_id = var.tag_cicd_id
    },
    {
      tag_id = uptimekuma_tag.forgejo.id
    }
  ]
}

# ============================================================== #
# -------------------------------------------------------------- #
# | Monitors                                                   | #
# -------------------------------------------------------------- #
# ============================================================== #

# -------------------------------------------------------------- #
# | Forgejo WebUI                                              | #
# -------------------------------------------------------------- #

resource "uptimekuma_monitor_ping" "forgejo" {
  name = "Forgejo (Ping)"

  hostname = var.forgejo_endpoint

  interval         = 60
  timeout          = 30
  max_retries      = 2
  retry_interval   = 60
  packet_size      = 56
  notification_ids = [var.notification_discord]
  parent           = uptimekuma_monitor_group.forgejo_webui.id
  tags = [
    {
      tag_id = var.tag_cicd_id
    },
    {
      tag_id = uptimekuma_tag.forgejo.id
    },
    {
      tag_id = var.tag_ping_id
    }
  ]
}

resource "uptimekuma_monitor_http" "forgejo" {
  name             = "Forgejo (HTTP)"
  url              = "https://${var.forgejo_endpoint}"
  interval         = 60
  timeout          = 10
  active           = true
  notification_ids = [var.notification_discord]
  parent           = uptimekuma_monitor_group.forgejo_webui.id
  tags = [
    {
      tag_id = var.tag_cicd_id
    },
    {
      tag_id = uptimekuma_tag.forgejo.id
    },
    {
      tag_id = var.tag_http_id
    }
  ]
}

resource "uptimekuma_monitor_docker" "forgejo" {
  name             = "Forgejo WebUI"
  description      = "Monitor Forgejo docker container"
  docker_host_id   = var.docker_default_host
  docker_container = "forgejo"
  interval         = 60
  max_retries      = 2
  notification_ids = [var.notification_discord]
  parent           = uptimekuma_monitor_group.forgejo_webui.id
  tags = [
    {
      tag_id = var.tag_cicd_id
    },
    {
      tag_id = uptimekuma_tag.forgejo.id
    },
    {
      tag_id = var.tag_docker_id
    }
  ]
}

# -------------------------------------------------------------- #
# | Forgejo PostgreSQL                                         | #
# -------------------------------------------------------------- #

resource "uptimekuma_monitor_postgres" "forgejo" {
  name                       = "Forgejo (PostgreSQL)"
  database_connection_string = "postgres://${var.forgejo_database_user}:${var.forgejo_database_password}@${var.forgejo_database_hostname}:${var.forgejo_database_port}/${var.forgejo_database_name}"
  database_query             = "SELECT 1"
  interval                   = 300
  retry_interval             = 60
  max_retries                = 2
  active                     = true
  notification_ids           = [var.notification_discord]
  parent                     = uptimekuma_monitor_group.forgejo_db.id
  tags = [
    {
      tag_id = var.tag_cicd_id
    },
    {
      tag_id = uptimekuma_tag.forgejo.id
    },
    {
      tag_id = var.tag_postgresql_id
    }
  ]
}

resource "uptimekuma_monitor_docker" "forgejo_postgres" {
  name             = "Forgejo PostgreSQL (Docker)"
  description      = "Monitor Forgejo PostgreSQL docker container"
  docker_host_id   = var.docker_default_host
  docker_container = "forgejo_postgres"
  interval         = 60
  max_retries      = 2
  notification_ids = [var.notification_discord]
  parent           = uptimekuma_monitor_group.forgejo_db.id
  tags = [
    {
      tag_id = var.tag_cicd_id
    },
    {
      tag_id = uptimekuma_tag.forgejo.id
    },
    {
      tag_id = var.tag_docker_id
    }
  ]
}

# -------------------------------------------------------------- #
# | Forgejo Runners                                            | #
# -------------------------------------------------------------- #

resource "uptimekuma_monitor_docker" "forgejo_runner" {
  name             = "Forgejo Runner"
  description      = "Monitor Forgejo CI/CD runner"
  docker_host_id   = var.docker_default_host
  docker_container = "forgejo-runner"
  interval         = 60
  max_retries      = 2
  notification_ids = [var.notification_discord]
  parent           = uptimekuma_monitor_group.forgejo.id
  tags = [
    {
      tag_id = var.tag_cicd_id
    },
    {
      tag_id = uptimekuma_tag.forgejo.id
    },
    {
      tag_id = var.tag_docker_id
    }
  ]
}

# -------------------------------------------------------------- #
# | Forgejo Runners                                            | #
# -------------------------------------------------------------- #

resource "uptimekuma_monitor_docker" "forgejo_dind" {
  name             = "Forgejo Docker-in-Docker"
  description      = "Monitor Forgejo DinD service"
  docker_host_id   = var.docker_default_host
  docker_container = "forgejo-dind"
  interval         = 60
  max_retries      = 2
  notification_ids = [var.notification_discord]
  parent           = uptimekuma_monitor_group.forgejo.id
  tags = [
    {
      tag_id = var.tag_cicd_id
    },
    {
      tag_id = uptimekuma_tag.forgejo.id
    },
    {
      tag_id = var.tag_docker_id
    }
  ]
}
