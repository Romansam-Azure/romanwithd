variable "scaling_name" {}
variable "location" {}
variable "resource_group_name" {}
variable "enable_scaling_plan" { }
variable "host_pool_ids" {
  type        = list(string)
  description = "List of host pool resource IDs to attach to the scaling plan"
  default     = []
}