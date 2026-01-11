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
    restore_traffic_time_to_healed_or_new_endpoint_in_minutes = optional(number, 10)
    session_affinity_enabled                                  = optional(bool, true)
    load_balancing = object({
      additional_latency_in_milliseconds = optional(number, 50)
      sample_size                        = optional(number, 4)
      successful_samples_required        = optional(number, 3)
    })
    health_probe = optional(object({
      interval_in_seconds = number
      path                = optional(string, "/")
      protocol            = string
      request_type        = optional(string, "HEAD")
    }))
  }))
}

