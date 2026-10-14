variable "policy_scope" {
  type = string
  description = "Scope for policies to be applied to"
  default = ""
}

variable "location" {
  description = "location for policy"
  type = string
  default = ""
}

variable "policyname" {
  description = "Scope for policies to be applied to"
  type = string
  default = ""
}

variable "policy_definition_id" {
  description = "location for NZISM"
  type = string
  default = ""
}

variable "description" {
  description = "Policy Description"
  type = string
  default = ""
}

variable "display_name" {
  description = "Displayname for policy"
  type = string
  default = ""
}


variable "midname" {
  type = string
}

variable "resource_group_name" {
  type = string
}
