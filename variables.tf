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
  # path: load_balancing.additional_latency_in_milliseconds
  #   condition: value >= 0 && value <= 1000
  #   message:   must be between 0 and 1000
  # path: load_balancing.sample_size
  #   condition: value >= 0 && value <= 255
  #   message:   must be between 0 and 255
  # path: load_balancing.successful_samples_required
  #   condition: value >= 0 && value <= 255
  #   message:   must be between 0 and 255
  # path: health_probe.protocol
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: health_probe.request_type
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: health_probe.interval_in_seconds
  #   condition: value >= 1 && value <= 255
  #   message:   must be between 1 and 255
  # path: health_probe.path
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: restore_traffic_time_to_healed_or_new_endpoint_in_minutes
  #   condition: value >= 0 && value <= 50
  #   message:   must be between 0 and 50
}

