output "tag_cicd_id" {
  value = uptimekuma_tag.cicd.id
}

output "tag_critical_id" {
  value = uptimekuma_tag.critical.id
}

output "tag_monitoring_id" {
  value = uptimekuma_tag.monitoring.id
}

# -------------------------------------------------------------- #
# | Notifications                                              | #
# -------------------------------------------------------------- #

output "notification_discord" {
  value = uptimekuma_notification_discord.discord_notification.id
}

# -------------------------------------------------------------- #
# | Monitor Groups                                             | #
# -------------------------------------------------------------- #

output "group_network_id" {
  value = uptimekuma_monitor_group.network.id
}
