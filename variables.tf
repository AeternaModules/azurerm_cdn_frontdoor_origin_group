variable "cdn_frontdoor_origin_groups" {
  description = <<EOT
Map of cdn_frontdoor_origin_groups, attributes below
Required:
    - cdn_frontdoor_profile_id
    - name
    - load_balancing (block):
        - additional_latency_in_milliseconds (optional)
        - sample_size (optional)
        - successful_samples_required (optional)
Optional:
    - restore_traffic_time_to_healed_or_new_endpoint_in_minutes
    - session_affinity_enabled
    - health_probe (block):
        - interval_in_seconds (required)
        - path (optional)
        - protocol (required)
        - request_type (optional)
EOT

  type = map(object({
    cdn_frontdoor_profile_id                                  = string
    name                                                      = string
    restore_traffic_time_to_healed_or_new_endpoint_in_minutes = optional(number)
    session_affinity_enabled                                  = optional(bool)
    load_balancing = object({
      additional_latency_in_milliseconds = optional(number)
      sample_size                        = optional(number)
      successful_samples_required        = optional(number)
    })
    health_probe = optional(object({
      interval_in_seconds = number
      path                = optional(string)
      protocol            = string
      request_type        = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.cdn_frontdoor_origin_groups : (
        v.load_balancing.additional_latency_in_milliseconds == null || (v.load_balancing.additional_latency_in_milliseconds >= 0 && v.load_balancing.additional_latency_in_milliseconds <= 1000)
      )
    ])
    error_message = "must be between 0 and 1000"
  }
  validation {
    condition = alltrue([
      for k, v in var.cdn_frontdoor_origin_groups : (
        v.load_balancing.sample_size == null || (v.load_balancing.sample_size >= 0 && v.load_balancing.sample_size <= 255)
      )
    ])
    error_message = "must be between 0 and 255"
  }
  validation {
    condition = alltrue([
      for k, v in var.cdn_frontdoor_origin_groups : (
        v.load_balancing.successful_samples_required == null || (v.load_balancing.successful_samples_required >= 0 && v.load_balancing.successful_samples_required <= 255)
      )
    ])
    error_message = "must be between 0 and 255"
  }
  validation {
    condition = alltrue([
      for k, v in var.cdn_frontdoor_origin_groups : (
        v.health_probe == null || (v.health_probe.interval_in_seconds >= 1 && v.health_probe.interval_in_seconds <= 255)
      )
    ])
    error_message = "must be between 1 and 255"
  }
  validation {
    condition = alltrue([
      for k, v in var.cdn_frontdoor_origin_groups : (
        v.health_probe == null || (v.health_probe.path == null || (length(v.health_probe.path) > 0))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.cdn_frontdoor_origin_groups : (
        v.restore_traffic_time_to_healed_or_new_endpoint_in_minutes == null || (v.restore_traffic_time_to_healed_or_new_endpoint_in_minutes >= 0 && v.restore_traffic_time_to_healed_or_new_endpoint_in_minutes <= 50)
      )
    ])
    error_message = "must be between 0 and 50"
  }
  # Note: 5 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

