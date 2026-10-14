variable "scaling_name" {
  description = "The name of the scaling plan"
  type        = string
}

variable "location" {
  description = "The Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "weekday_rampup_mpoh" {
  description = "Weekday ramp-up minutes per host"
  type        = number
  default     = null
}

variable "weekday_rempdown_mpoh" {
  description = "Weekday ramp-down minutes per host"
  type        = number
  default     = null
}

variable "weekend_rampup_mpoh" {
  description = "Weekend ramp-up minutes per host"
  type        = number
  default     = null
}

variable "weekend_rempdown_mpoh" {
  description = "Weekend ramp-down minutes per host"
  type        = number
  default     = null
}

variable "patching_rampup_mpoh" {
  description = "Patching day ramp-up minutes per host"
  type        = number
  default     = null
}

variable "patching_rempdown_mpoh" {
  description = "Patching day ramp-down minutes per host"
  type        = number
  default     = null
}

variable "host_pool_ids" {
  description = "List of AVD host pool IDs to apply this scaling plan to"
  type        = list(string)
}
