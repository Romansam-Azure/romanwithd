variable "budget_name" {
  description = "The name of the Azure Consumption Budget."
  type        = string
}

variable "subscription_id" {
  description = "The ID of the Azure subscription for which the budget is set."
  type        = string
}

variable "amount" {
  description = "The amount of the budget in the specified currency."
  type        = number
}

variable "time_grain" {
  description = "The time period over which the budget is tracked. Possible values are 'Monthly', 'Quarterly', 'Annually'."
  type        = string
}

variable "start_date" {
  description = "The start date for the budget in the format 'YYYY-MM-DDTHH:MM:SSZ'."
  type        = string
}

variable "end_date" {
  description = "The end date for the budget in the format 'YYYY-MM-DDTHH:MM:SSZ'."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group to filter the budget on."
  type        = string
}

variable "contact_emails" {
  description = "A list of contact emails for notifications."
  type        = list(string)
}

variable "contact_roles" {
  description = "A list of contact roles for notifications."
  type        = list(string)
}

variable "notifications" {
  description = "A map of notifications with threshold, operator, and whether they are enabled."
  type        = list(object({
    threshold      = number
    operator       = string
    threshold_type = string
    enabled        = bool
  }))
}
