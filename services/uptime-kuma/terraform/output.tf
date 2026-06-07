##################################################################
## ------------------------------------------------------------ ##
## | Tags                                                     | ##
## ------------------------------------------------------------ ##
##################################################################

output "tag_http_id" {
  value = uptimekuma_tag.http.id
}

output "tag_ping_id" {
  value = uptimekuma_tag.ping.id
}

output "tag_postgresql_id" {
  value = uptimekuma_tag.postgresql.id
}

output "tag_docker_id" {
  value = uptimekuma_tag.docker.id
}


output "tag_critical_id" {
  value = uptimekuma_tag.critical.id
}

output "tag_cicd_id" {
  value = uptimekuma_tag.cicd.id
}

output "tag_networking_id" {
  value = uptimekuma_tag.networking.id
}


output "tag_tools_id" {
  value = uptimekuma_tag.tools.id
}

##################################################################
## ------------------------------------------------------------ ##
## | Notifications                                            | ##
## ------------------------------------------------------------ ##
##################################################################

output "notification_discord" {
  value = uptimekuma_notification_discord.discord_notification.id
}

##################################################################
## ------------------------------------------------------------ ##
## | Monitor Groups                                           | ##
## ------------------------------------------------------------ ##
##################################################################

output "group_cicd_id" {
  value = uptimekuma_monitor_group.cicd.id
}

output "group_network_id" {
  value = uptimekuma_monitor_group.network.id
}

output "group_tools_id" {
  value = uptimekuma_monitor_group.tools.id
}

##################################################################
## ------------------------------------------------------------ ##
## | Docker Host                                              | ##
## ------------------------------------------------------------ ##
##################################################################

output "docker_default_host_id" {
  value = uptimekuma_docker_host.docker_default_host.id
}