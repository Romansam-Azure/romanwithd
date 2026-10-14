# sitecore-xp-deployment/modules/sql/variables.tf

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "deployment_id" {
  type = string
}

variable "sql_server_name" {
  type = string
}

variable "sql_admin_username" {
  type = string
  default   = "" # Prevents Terraform prompt during plan
}

variable "sql_admin_password" {
  type      = string
  sensitive = true
  default   = "" # Prevents Terraform prompt during plan
}

variable "sql_server_version" {
  type    = string
  default = "12.0"
}

variable "sql_database_collation" {
  type    = string
  default = "SQL_Latin1_General_CP1_CI_AS"
}

variable "databases" {
  type = map(object({
    name = string
  }))
}
