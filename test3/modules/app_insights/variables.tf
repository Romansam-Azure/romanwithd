# sitecore-xp-deployment/modules/app_insights/variables.tf

variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "app_insights_name" { type = string }
variable "workspace_id" {
  description = "ID of the Log Analytics workspace to link to Application Insights"
  type        = string
}
