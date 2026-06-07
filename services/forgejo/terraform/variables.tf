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

variable "tag_postgresql_id" {
  type = number
}

variable "tag_cicd_id" {
  type = number
}

variable "group_cicd_id" {
  type = number
}

variable "notification_discord" {
  type = number
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

