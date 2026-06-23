##################################################################
## ------------------------------------------------------------ ##
## | Forgejo                                                  | ##
## ------------------------------------------------------------ ##
##################################################################

variable "immich_endpoint" {
  type     = string
  nullable = false
}

variable "immich_database_hostname" {
  type      = string
  nullable  = false
  sensitive = true
}

variable "immich_database_port" {
  type     = number
  nullable = false
}

variable "immich_database_user" {
  type      = string
  nullable  = false
  sensitive = true
}

variable "immich_database_password" {
  type      = string
  nullable  = false
  sensitive = true
}

variable "immich_database_name" {
  type     = string
  nullable = false
}

##################################################################
## ------------------------------------------------------------ ##
## | Tags                                                     | ##
## ------------------------------------------------------------ ##
##################################################################

variable "tag_http_id" {
  type = number
}

variable "tag_ping_id" {
  type = number
}

variable "tag_postgresql_id" {
  type = number
}

variable "tag_docker_id" {
  type = number
}

variable "tag_media_id" {
  type = number
}

##################################################################
## ------------------------------------------------------------ ##
## | Monitor Groups                                           | ##
## ------------------------------------------------------------ ##
##################################################################

variable "group_media_id" {
  type = number
}

##################################################################
## ------------------------------------------------------------ ##
## | Notifications                                            | ##
## ------------------------------------------------------------ ##
##################################################################

variable "discord_ping_webhook" {
  type = number
}

variable "discord_docker_webhook" {
  type = number
}

variable "discord_postgres_webhook" {
  type = number
}

variable "discord_traefik_webhook" {
  type = number
}

##################################################################
## ------------------------------------------------------------ ##
## | Docker Host                                              | ##
## ------------------------------------------------------------ ##
##################################################################

variable "docker_default_host" {
  type     = string
  nullable = false
}
