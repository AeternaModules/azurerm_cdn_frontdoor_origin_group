resource "azurerm_cdn_frontdoor_origin_group" "cdn_frontdoor_origin_groups" {
  for_each = var.cdn_frontdoor_origin_groups

  cdn_frontdoor_profile_id                                  = each.value.cdn_frontdoor_profile_id
  name                                                      = each.value.name
  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = each.value.restore_traffic_time_to_healed_or_new_endpoint_in_minutes
  session_affinity_enabled                                  = each.value.session_affinity_enabled

  load_balancing {
    additional_latency_in_milliseconds = each.value.load_balancing.additional_latency_in_milliseconds
    sample_size                        = each.value.load_balancing.sample_size
    successful_samples_required        = each.value.load_balancing.successful_samples_required
  }

  dynamic "health_probe" {
    for_each = each.value.health_probe != null ? [each.value.health_probe] : []
    content {
      interval_in_seconds = health_probe.value.interval_in_seconds
      path                = health_probe.value.path
      protocol            = health_probe.value.protocol
      request_type        = health_probe.value.request_type
    }
  }
}

