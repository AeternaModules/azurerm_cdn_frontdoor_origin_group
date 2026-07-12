output "cdn_frontdoor_origin_groups_cdn_frontdoor_profile_id" {
  description = "Map of cdn_frontdoor_profile_id values across all cdn_frontdoor_origin_groups, keyed the same as var.cdn_frontdoor_origin_groups"
  value       = { for k, v in azurerm_cdn_frontdoor_origin_group.cdn_frontdoor_origin_groups : k => v.cdn_frontdoor_profile_id }
}
output "cdn_frontdoor_origin_groups_health_probe" {
  description = "Map of health_probe values across all cdn_frontdoor_origin_groups, keyed the same as var.cdn_frontdoor_origin_groups"
  value       = { for k, v in azurerm_cdn_frontdoor_origin_group.cdn_frontdoor_origin_groups : k => v.health_probe }
}
output "cdn_frontdoor_origin_groups_load_balancing" {
  description = "Map of load_balancing values across all cdn_frontdoor_origin_groups, keyed the same as var.cdn_frontdoor_origin_groups"
  value       = { for k, v in azurerm_cdn_frontdoor_origin_group.cdn_frontdoor_origin_groups : k => v.load_balancing }
}
output "cdn_frontdoor_origin_groups_name" {
  description = "Map of name values across all cdn_frontdoor_origin_groups, keyed the same as var.cdn_frontdoor_origin_groups"
  value       = { for k, v in azurerm_cdn_frontdoor_origin_group.cdn_frontdoor_origin_groups : k => v.name }
}
output "cdn_frontdoor_origin_groups_restore_traffic_time_to_healed_or_new_endpoint_in_minutes" {
  description = "Map of restore_traffic_time_to_healed_or_new_endpoint_in_minutes values across all cdn_frontdoor_origin_groups, keyed the same as var.cdn_frontdoor_origin_groups"
  value       = { for k, v in azurerm_cdn_frontdoor_origin_group.cdn_frontdoor_origin_groups : k => v.restore_traffic_time_to_healed_or_new_endpoint_in_minutes }
}
output "cdn_frontdoor_origin_groups_session_affinity_enabled" {
  description = "Map of session_affinity_enabled values across all cdn_frontdoor_origin_groups, keyed the same as var.cdn_frontdoor_origin_groups"
  value       = { for k, v in azurerm_cdn_frontdoor_origin_group.cdn_frontdoor_origin_groups : k => v.session_affinity_enabled }
}

