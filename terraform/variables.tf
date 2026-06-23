# -------------------------------------------------- #
# | Code Server                                    | #
# -------------------------------------------------- #

variable "code_server_endpoint" {
  type     = string
  nullable = false
}

# -------------------------------------------------- #
# | Forgejo                                        | #
# -------------------------------------------------- #

variable "forgejo_endpoint" {
  type     = string
  nullable = false
}

variable "forgejo_database_hostname" {
  type      = string
  nullable  = false
  sensitive = true
}

variable "forgejo_database_port" {
  type     = number
  nullable = false
}

variable "forgejo_database_user" {
  type      = string
  nullable  = false
  sensitive = true
}

variable "forgejo_database_password" {
  type      = string
  nullable  = false
  sensitive = true
}

variable "forgejo_database_name" {
  type     = string
  nullable = false
}

# -------------------------------------------------- #
# | Homepage                                       | #
# -------------------------------------------------- #

variable "homepage_endpoint" {
  type     = string
  nullable = false
}

# -------------------------------------------------- #
# | Immich                                         | #
# -------------------------------------------------- #

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

# -------------------------------------------------- #
# | Traefik                                        | #
# -------------------------------------------------- #

variable "traefik_endpoint" {
  type     = string
  nullable = false
}

# -------------------------------------------------- #
# | Uptime-kuma                                    | #
# -------------------------------------------------- #

variable "uptime_kuma_endpoint" {
  type        = string
  description = "Base URL of the Uptime Kuma instance"
  nullable    = false
}

variable "uptime_kuma_username" {
  type        = string
  description = "Username for authentication"
  nullable    = false
  sensitive   = true
}

variable "uptime_kuma_password" {
  type        = string
  description = "Password for authentication"
  nullable    = false
  sensitive   = true
}

variable "discord_ping_webhook" {
  type = string
  description = "Webhook URL for Disocrd notifications"
  nullable = true
  sensitive = true
}

variable "discord_docker_webhook" {
  type = string
  description = "Webhook URL for Disocrd notifications"
  nullable = true
  sensitive = true
}

variable "discord_postgres_webhook" {
  type = string
  description = "Webhook URL for Disocrd notifications"
  nullable = true
  sensitive = true
}

variable "discord_traefik_webhook" {
  type = string
  description = "Webhook URL for Disocrd notifications"
  nullable = true
  sensitive = true
}