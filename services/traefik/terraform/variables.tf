variable "traefik_endpoint" {
  type     = string
  nullable = false
}

variable "tag_critical_id" {
  type = number
}

variable "group_network_id" {
  type = number
}

variable "notification_discord" {
  type = number
}

