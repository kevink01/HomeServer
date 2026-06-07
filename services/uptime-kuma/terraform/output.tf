output "tag_cicd_id" {
  value = uptimekuma_tag.cicd.id
  type = number
}

output "tag_critical_id" {
  value = uptimekuma_tag.critical.id
  type = number
}

output "tag_monitoring_id" {
  value = uptimekuma_tag.monitoring.id
  type = number
}

# -------------------------------------------------------------- #
# | Notifications                                              | #
# -------------------------------------------------------------- #

output "notification_discord" {
  value = uptimekuma_notification_discord.discord_notification.id
  type = number
}

# -------------------------------------------------------------- #
# | Monitor Groups                                             | #
# -------------------------------------------------------------- #

output "group_network_id" {
  value = uptimekuma_monitor_group.network.id
  type = number
}
