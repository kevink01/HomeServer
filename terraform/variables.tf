# -------------------------------------------------- #
# | Code Server                                    | #
# -------------------------------------------------- #

variable "code_server_endpoint" {
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
