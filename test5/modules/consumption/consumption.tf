resource "azurerm_monitor_action_group" "consumption" {
  name                = "consumption_budget_alert"
  resource_group_name = var.resource_group_name
  short_name          = "consumption"
}

resource "azurerm_consumption_budget_subscription" "example" {
  name            = var.budget_name
  subscription_id = var.subscription_id
  amount          = var.amount
  time_grain      = var.time_grain

  time_period {
    start_date = var.start_date
    end_date   = var.end_date
  }

  dynamic "notification" {
    for_each = var.notifications
    content {
      enabled        = notification.value.enabled
      threshold      = notification.value.threshold
      operator       = notification.value.operator
      threshold_type = notification.value.threshold_type

      contact_emails = var.contact_emails
      contact_groups = [
      azurerm_monitor_action_group.consumption.id,
    ]
      contact_roles  = var.contact_roles
    }
  }
}
