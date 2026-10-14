terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "~>3.0"
      configuration_aliases = [azurerm]
    }
    // azapi = {
    //   source  = "azure/azapi"
    //   version = "~>1.12"
    // }
  }
}


resource "azurerm_virtual_desktop_scaling_plan" "this" {
  name                = var.scaling_name
  location            = var.location
  resource_group_name = var.resource_group_name
  friendly_name       = var.scaling_name
  description         =  "Scaling plan for pooled desktops"
  time_zone = "Cen. Australia Standard Time"

  tags = {
    "Business.Application"     = "avd"
    "Business.EnvironmentType" = "prd"
    "Object.Region"            = "ae"
    "Project.code"             = "N.571.25.6795"
  }

  schedule {
    name                                 = "Weekdays"
    days_of_week                         = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    ramp_up_start_time                   = "07:00"
    ramp_up_load_balancing_algorithm     = "BreadthFirst"
    ramp_up_minimum_hosts_percent        = var.weekday_rampup_mpoh
    ramp_up_capacity_threshold_percent   = 50
    peak_start_time                      = "08:00"
    peak_load_balancing_algorithm        = "BreadthFirst"
    ramp_down_start_time                 = "18:00"
    ramp_down_load_balancing_algorithm   = "DepthFirst"
    ramp_down_minimum_hosts_percent      = var.weekday_rempdown_mpoh
    ramp_down_force_logoff_users         = false
    ramp_down_wait_time_minutes          = 45
    ramp_down_notification_message       = "Please log off in the next 45 minutes..."
    ramp_down_capacity_threshold_percent = 60
    ramp_down_stop_hosts_when            = "ZeroSessions"
    off_peak_start_time                  = "20:00"
    off_peak_load_balancing_algorithm    = "DepthFirst"
  }

  schedule {
    name                                 = "weekend"
    days_of_week                         = ["Sunday"]
    ramp_up_start_time                   = "07:00"
    ramp_up_load_balancing_algorithm     = "DepthFirst"
    ramp_up_minimum_hosts_percent        = var.weekend_rampup_mpoh
    ramp_up_capacity_threshold_percent   = 95
    peak_start_time                      = "08:00"
    peak_load_balancing_algorithm        = "DepthFirst"
    ramp_down_start_time                 = "18:00"
    ramp_down_load_balancing_algorithm   = "DepthFirst"
    ramp_down_minimum_hosts_percent      = var.weekend_rempdown_mpoh
    ramp_down_force_logoff_users         = false
    ramp_down_wait_time_minutes          = 15
    ramp_down_notification_message       = "Scheduled patching is starting soon. You will be logged off."
    ramp_down_capacity_threshold_percent = 95
    ramp_down_stop_hosts_when            = "ZeroSessions"
    off_peak_start_time                  = "20:00"
    off_peak_load_balancing_algorithm    = "DepthFirst"
  }

   schedule {
    name                                 = "patching"
    days_of_week                         = ["Saturday"]
    ramp_up_start_time                   = "00:00"
    ramp_up_load_balancing_algorithm     = "DepthFirst"
    ramp_up_minimum_hosts_percent        = var.patching_rampup_mpoh
    ramp_up_capacity_threshold_percent   = 95
    peak_start_time                      = "01:00"
    peak_load_balancing_algorithm        = "DepthFirst"
    ramp_down_start_time                 = "02:00"
    ramp_down_load_balancing_algorithm   = "DepthFirst"
    ramp_down_minimum_hosts_percent      = var.patching_rempdown_mpoh
    ramp_down_force_logoff_users         = false
    ramp_down_wait_time_minutes          = 15
    ramp_down_notification_message       = "Scheduled patching is starting soon. You will be logged off."
    ramp_down_capacity_threshold_percent = 95
    ramp_down_stop_hosts_when            = "ZeroSessions"
    off_peak_start_time                  = "03:00"
    off_peak_load_balancing_algorithm    = "DepthFirst"
  }

  dynamic "host_pool" {
    for_each = var.host_pool_ids
    content {
      hostpool_id          = host_pool.value
      scaling_plan_enabled = true
    }
  }
}
