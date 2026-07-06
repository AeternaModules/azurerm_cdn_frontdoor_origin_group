output "cdn_frontdoor_origin_groups" {
  description = "All cdn_frontdoor_origin_group resources"
  value       = azurerm_cdn_frontdoor_origin_group.cdn_frontdoor_origin_groups
}
output "cdn_frontdoor_origin_groups_cdn_frontdoor_profile_id" {
  description = "List of cdn_frontdoor_profile_id values across all cdn_frontdoor_origin_groups"
  value       = [for k, v in azurerm_cdn_frontdoor_origin_group.cdn_frontdoor_origin_groups : v.cdn_frontdoor_profile_id]
}
output "cdn_frontdoor_origin_groups_health_probe" {
  description = "List of health_probe values across all cdn_frontdoor_origin_groups"
  value       = [for k, v in azurerm_cdn_frontdoor_origin_group.cdn_frontdoor_origin_groups : v.health_probe]
}
output "cdn_frontdoor_origin_groups_load_balancing" {
  description = "List of load_balancing values across all cdn_frontdoor_origin_groups"
  value       = [for k, v in azurerm_cdn_frontdoor_origin_group.cdn_frontdoor_origin_groups : v.load_balancing]
}
output "cdn_frontdoor_origin_groups_name" {
  description = "List of name values across all cdn_frontdoor_origin_groups"
  value       = [for k, v in azurerm_cdn_frontdoor_origin_group.cdn_frontdoor_origin_groups : v.name]
}
output "cdn_frontdoor_origin_groups_restore_traffic_time_to_healed_or_new_endpoint_in_minutes" {
  description = "List of restore_traffic_time_to_healed_or_new_endpoint_in_minutes values across all cdn_frontdoor_origin_groups"
  value       = [for k, v in azurerm_cdn_frontdoor_origin_group.cdn_frontdoor_origin_groups : v.restore_traffic_time_to_healed_or_new_endpoint_in_minutes]
}
output "cdn_frontdoor_origin_groups_session_affinity_enabled" {
  description = "List of session_affinity_enabled values across all cdn_frontdoor_origin_groups"
  value       = [for k, v in azurerm_cdn_frontdoor_origin_group.cdn_frontdoor_origin_groups : v.session_affinity_enabled]
}

