variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "service_plan_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "app_command_line" {
  type = string
}

variable "app_insights_key" {
  type = string
}

variable "app_insights_connection_string" {
  type    = string
  default = ""
}

variable "ip_restrictions" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}