terraform {
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~>1.12"
    }
  }
}

data "azurerm_resource_group" "existing_rg" {
  name = var.resource_group_name
}


resource "azapi_resource" "scaling_plan_personal" {
  count     = var.enable_scaling_plan ? 1 : 0
  type      = "Microsoft.DesktopVirtualization/scalingPlans@2023-11-01-preview"
  name      = var.scaling_name
  location  = var.location
  parent_id = data.azurerm_resource_group.existing_rg.id

  tags = {
    "Business.Application"     = "avd"
    "Business.EnvironmentType" = "prd"
    "Object.Region"            = "ae"
    "Project.code"             = "N.571.25.6795"
  }

  body = jsonencode({
    properties = {
      timeZone           = "UTC"
      hostPoolType       = "Personal"
      exclusionTag       = "Maintenance"
      schedules          = []
      hostPoolReferences = [
        for hp_id in var.host_pool_ids : {
          hostPoolArmPath    = hp_id
          scalingPlanEnabled = true
        }
      ]
    }
  })
}


resource "azapi_resource" "personal_schedule" {
  count     = var.enable_scaling_plan ? 1 : 0
  type      = "Microsoft.DesktopVirtualization/scalingPlans/personalSchedules@2023-11-01-preview"
  name      = "Weekdays"
  parent_id = azapi_resource.scaling_plan_personal[0].id

  body = jsonencode({
    properties = {
      daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]

      rampUpStartTime = {
        hour   = 7,
        minute = 0
      },
      rampUpAutoStartHosts            = "None",
      rampUpStartVMOnConnect          = "Enable",
      rampUpMinutesToWaitOnDisconnect = 45,
      rampUpActionOnDisconnect        = "Hibernate",
      rampUpMinutesToWaitOnLogoff     = 30,
      rampUpActionOnLogoff            = "Hibernate",

      peakStartTime = {
        hour   = 8,
        minute = 0
      },
      peakStartVMOnConnect          = "Enable",
      peakMinutesToWaitOnDisconnect = 60,
      peakActionOnDisconnect        = "Hibernate",
      peakMinutesToWaitOnLogoff     = 60,
      peakActionOnLogoff            = "Hibernate",

      rampDownStartTime = {
        hour   = 16,
        minute = 30
      },
      rampDownStartVMOnConnect          = "Enable",
      rampDownMinutesToWaitOnDisconnect = 45,
      rampDownActionOnDisconnect        = "Hibernate",
      rampDownMinutesToWaitOnLogoff     = 30,
      rampDownActionOnLogoff            = "Hibernate",

      offPeakStartTime = {
        hour   = 17,
        minute = 30
      },
      offPeakStartVMOnConnect          = "Enable",
      offPeakMinutesToWaitOnDisconnect = 20,
      offPeakActionOnDisconnect        = "Hibernate",
      offPeakMinutesToWaitOnLogoff     = 15,
      offPeakActionOnLogoff            = "Hibernate"
    }
  })
}


resource "azapi_resource" "personal_schedule_saturday" {
  count     = var.enable_scaling_plan ? 1 : 0
  type      = "Microsoft.DesktopVirtualization/scalingPlans/personalSchedules@2023-11-01-preview"
  name      = "Saturday-Patching"
  parent_id = azapi_resource.scaling_plan_personal[0].id

  body = jsonencode({
    properties = {
      daysOfWeek = ["Saturday"]

      rampUpStartTime = {
        hour   = 6,
        minute = 0
      },
      rampUpAutoStartHosts            = "None",
      rampUpStartVMOnConnect          = "Enable",
      rampUpMinutesToWaitOnDisconnect = 30,
      rampUpActionOnDisconnect        = "Hibernate",
      rampUpMinutesToWaitOnLogoff     = 20,
      rampUpActionOnLogoff            = "Hibernate",

      peakStartTime = {
        hour   = 7,
        minute = 0
      },
      peakStartVMOnConnect          = "Enable",
      peakMinutesToWaitOnDisconnect = 45,
      peakActionOnDisconnect        = "Hibernate",
      peakMinutesToWaitOnLogoff     = 30,
      peakActionOnLogoff            = "Hibernate",

      rampDownStartTime = {
        hour   = 12,
        minute = 0
      },
      rampDownStartVMOnConnect          = "Enable",
      rampDownMinutesToWaitOnDisconnect = 30,
      rampDownActionOnDisconnect        = "Hibernate",
      rampDownMinutesToWaitOnLogoff     = 20,
      rampDownActionOnLogoff            = "Hibernate",

      offPeakStartTime = {
        hour   = 14,
        minute = 0
      },
      offPeakStartVMOnConnect          = "Enable",
      offPeakMinutesToWaitOnDisconnect = 15,
      offPeakActionOnDisconnect        = "Hibernate",
      offPeakMinutesToWaitOnLogoff     = 10,
      offPeakActionOnLogoff            = "Hibernate"
    }
  })
}

