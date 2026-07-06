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
    restore_traffic_time_to_healed_or_new_endpoint_in_minutes = optional(number) # Default: 10
    session_affinity_enabled                                  = optional(bool)   # Default: true
    load_balancing = object({
      additional_latency_in_milliseconds = optional(number) # Default: 50
      sample_size                        = optional(number) # Default: 4
      successful_samples_required        = optional(number) # Default: 3
    })
    health_probe = optional(object({
      interval_in_seconds = number
      path                = optional(string) # Default: "/"
      protocol            = string
      request_type        = optional(string) # Default: "HEAD"
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
  # --- Unconfirmed validation candidates, derived from azurerm_cdn_frontdoor_origin_group's provider source ---
  # Not auto-enabled: either a bespoke provider validator we can't safely translate,
  # or a path that crosses a list-typed block (needs its own for_each wrapping).
  # Review, translate into a real validation{} block above, and delete once confirmed.
  # path: name
  #   source:    validate.FrontDoorOriginGroupName: no recognizable `if ... { errors = append(...) }` pattern - read it by hand
  # path: cdn_frontdoor_profile_id
  #   source:    [from validate.FrontDoorProfileID] !ok
  # path: cdn_frontdoor_profile_id
  #   source:    [from validate.FrontDoorProfileID] err != nil
  # path: health_probe.protocol
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: health_probe.request_type
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
}

