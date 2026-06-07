variable "forgejo_endpoint" {
  type     = string
  nullable = false
}

variable "tag_http_id" {
  type = number
}

variable "tag_ping_id" {
  type = number
}

variable "group_cicd_id" {
  type = number
}

variable "notification_discord" {
  type = number
}

