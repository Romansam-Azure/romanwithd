terraform {
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~> 2.6.0"
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

  body = {
    properties = {
      timeZone           = "Cen. Australia Standard Time"
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
  }

  lifecycle {
    ignore_changes = all
  }
}

resource "azapi_resource" "personal_schedule" {
  count     = var.enable_scaling_plan ? 1 : 0
  type      = "Microsoft.DesktopVirtualization/scalingPlans/personalSchedules@2023-11-01-preview"
  name      = "Weekdays"
  parent_id = azapi_resource.scaling_plan_personal[0].id

  body = {
    properties = {
      daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Sunday"]

      rampUpStartTime = {
        hour   = 7
        minute = 0
      },
      rampUpAutoStartHosts            = "None"
      rampUpStartVMOnConnect          = "Enable"
      rampUpMinutesToWaitOnDisconnect = 60
      rampUpActionOnDisconnect        = "Hibernate"
      rampUpMinutesToWaitOnLogoff     = 15
      rampUpActionOnLogoff            = "Deallocate"

      peakStartTime = {
        hour   = 10
        minute = 0
      },
      peakStartVMOnConnect          = "Enable"
      peakMinutesToWaitOnDisconnect = 60
      peakActionOnDisconnect        = "Hibernate"
      peakMinutesToWaitOnLogoff     = 15
      peakActionOnLogoff            = "Deallocate"

      rampDownStartTime = {
        hour   = 18
        minute = 0
      },
      rampDownStartVMOnConnect          = "Enable"
      rampDownMinutesToWaitOnDisconnect = 60
      rampDownActionOnDisconnect        = "Hibernate"
      rampDownMinutesToWaitOnLogoff     = 15
      rampDownActionOnLogoff            = "Deallocate"

      offPeakStartTime = {
        hour   = 20
        minute = 0
      },
      offPeakStartVMOnConnect          = "Enable"
      offPeakMinutesToWaitOnDisconnect = 60
      offPeakActionOnDisconnect        = "Hibernate"
      offPeakMinutesToWaitOnLogoff     = 15
      offPeakActionOnLogoff            = "Deallocate"
    }
  }
}


resource "azapi_resource" "personal_schedule_saturday" {
  count     = var.enable_scaling_plan ? 1 : 0
  type      = "Microsoft.DesktopVirtualization/scalingPlans/personalSchedules@2023-11-01-preview"
  name      = "Saturday-Patching"
  parent_id = azapi_resource.scaling_plan_personal[0].id

  body = {
    properties = {
      daysOfWeek = ["Saturday"]

      rampUpStartTime = {
        hour   = 0
        minute = 0
      },
      rampUpAutoStartHosts            = "All"
      rampUpStartVMOnConnect          = "Enable"
      rampUpMinutesToWaitOnDisconnect = 0
      rampUpActionOnDisconnect        = "Hibernate"
      rampUpMinutesToWaitOnLogoff     = 120
      rampUpActionOnLogoff            = "Deallocate"

      peakStartTime = {
        hour   = 1
        minute = 0
      },
      peakStartVMOnConnect          = "Enable"
      peakMinutesToWaitOnDisconnect = 120
      peakActionOnDisconnect        = "Hibernate"
      peakMinutesToWaitOnLogoff     = 15
      peakActionOnLogoff            = "Deallocate"

      rampDownStartTime = {
        hour   = 2
        minute = 0
      },
      rampDownStartVMOnConnect          = "Enable"
      rampDownMinutesToWaitOnDisconnect = 60
      rampDownActionOnDisconnect        = "Hibernate"
      rampDownMinutesToWaitOnLogoff     = 15
      rampDownActionOnLogoff            = "Deallocate"

      offPeakStartTime = {
        hour   = 3
        minute = 0
      },
      offPeakStartVMOnConnect          = "Enable"
      offPeakMinutesToWaitOnDisconnect = 60
      offPeakActionOnDisconnect        = "Hibernate"
      offPeakMinutesToWaitOnLogoff     = 15
      offPeakActionOnLogoff            = "Deallocate"
    }
  }
}
