terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "~>3.0"
      configuration_aliases = [azurerm]
    }
  }
}

data "azurerm_resource_group" "existing_rg" {
  name = var.resource_group_name
}

// data "azurerm_client_config" "current" {}

// resource "azurerm_key_vault_key" "avd_encryption_key" {
//   name         = "${var.host_pool_name}-encryption-key"
//   key_vault_id = var.key_vault_id
//   key_type     = "RSA"
//   key_size     = 2048

//   key_opts = [
//     "decrypt",
//     "encrypt",
//     "sign",
//     "verify",
//     "wrapKey",
//     "unwrapKey"
//   ]
//   lifecycle {
//     ignore_changes = all
//   }
// }

// resource "azurerm_disk_encryption_set" "avd_encryption_set" {
//   name                = "${var.host_pool_name}-des"
//   resource_group_name = var.resource_group_name
//   location            = var.location

//   identity {
//     type = "SystemAssigned"
//   }

//   encryption_type   = "EncryptionAtRestWithPlatformKey"
//   key_vault_key_id = azurerm_key_vault_key.avd_encryption_key.id

//   lifecycle {
//     ignore_changes = all
//   }
// }

// resource "azurerm_key_vault_access_policy" "disk_encryption_policy" {
//   key_vault_id = var.key_vault_id
//   tenant_id    = data.azurerm_client_config.current.tenant_id
//   object_id    = azurerm_disk_encryption_set.avd_encryption_set.identity[0].principal_id

//   key_permissions = [
//     "Get",
//     "WrapKey",
//     "UnwrapKey"
//   ]
//   lifecycle {
//     ignore_changes = all
//   }
// }

// resource "azurerm_key_vault_access_policy" "vm_identity_policy" {
//   count        = var.vm_count
//   key_vault_id = var.key_vault_id
//   tenant_id    = data.azurerm_client_config.current.tenant_id
//   object_id    = azurerm_windows_virtual_machine.session_host[count.index].identity[0].principal_id

//   key_permissions = [
//     "Get",
//     "WrapKey",
//     "UnwrapKey"
//   ]
//   lifecycle {
//     ignore_changes = all
//   }
// }

resource "azurerm_virtual_desktop_host_pool" "personal_pool" {
  name                             = var.host_pool_name
  location                         = var.location
  resource_group_name              = var.resource_group_name
  type                             = "Personal"
  personal_desktop_assignment_type = "Automatic"
  load_balancer_type               = "Persistent"
  preferred_app_group_type         = "Desktop"
  friendly_name                    = var.friendly_name
  validate_environment             = true
  start_vm_on_connect              = true
  scheduled_agent_updates {
    enabled = true
    use_session_host_timezone = true
    schedule {
      day_of_week = "Saturday"
      hour_of_day = 0
    }
  }

  custom_rdp_properties = <<EOT
    enablerdsaadauth:i:1;
    enablecredsspsupport:i:1;
    redirectprinters:i:0;
    redirectcomports:i:0;
    redirectsmartcards:i:0;
    redirectwebauthn:i:1;
    drivestoredirect:s:;
    devicestoredirect:s:;
    usbdevicestoredirect:s:;
    camerastoredirect:s:;
    audiomode:i:0;
    audiocapturemode:i:0;
    encode redirected video capture:i:1;
    redirected video capture encoding quality:i:0;
    videoplaybackmode:i:1;
    use multimon:i:1;
    smart sizing:i:1;
    dynamic resolution:i:1;
    desktopwidth:i:0;
    desktopheight:i:0;
    screen mode id:i:2;
    desktopscalefactor:i:0;
    span monitors:i:1;
    autoreconnection enabled:i:1;
    enableworkspacereconnect:i:1;
    bandwidthautodetect:i:1;
    networkautodetect:i:1;
    compression:i:1;
    disable wallpaper:i:1;
    allow font smoothing:i:1;
    allow desktop composition:i:1;
    disable full window drag:i:1;
    disable menu anims:i:1;
    disable themes:i:1;
    disable cursor setting:i:0;
    singlemoninwindowedmode:i:1;
  EOT

  tags = {
    "Business.Application"     = "avd"
    "Business.EnvironmentType" = "prd"
    "Object.Region"            = "ae"
    "Project.code"             = "N.571.25.6795"
  }
 lifecycle {
  ignore_changes = [
    tags,
    custom_rdp_properties
  ]
 }
}

resource "azurerm_virtual_desktop_application_group" "desktop" {
  name                         = var.applicationgroupname
  location                     = var.location
  resource_group_name          = var.resource_group_name
  host_pool_id                 = azurerm_virtual_desktop_host_pool.personal_pool.id
  type                         = "Desktop"
  friendly_name                = "${var.applicationgroupname}-dag"
  default_desktop_display_name = var.default_desktop_display_name != null ? var.default_desktop_display_name : null
  tags = {
    "Business.Application"     = "avd"
    "Business.EnvironmentType" = "prd"
    "Object.Region"            = "ae"
    "Project.code"             = "N.571.25.6795"
  }
  lifecycle {
    ignore_changes = all
  }
}

data "azuread_group" "example_group" {
  display_name = var.aad_group_display_name
}

resource "azurerm_role_assignment" "desktop_virtualization_user" {
  scope                = azurerm_virtual_desktop_application_group.desktop.id
  role_definition_name = "Desktop Virtualization User"
  principal_id         = data.azuread_group.example_group.id
  lifecycle {
    ignore_changes = [
      principal_id
    ]
  }
}

locals {
  workspace_id = var.existing_workspace_id
}

resource "azurerm_virtual_desktop_workspace_application_group_association" "association" {
  application_group_id = azurerm_virtual_desktop_application_group.desktop.id
  workspace_id         = local.workspace_id
}

resource "azurerm_network_interface" "session_host_nic" {
  count               = var.vm_count
  name                = "${var.vmhost_name}-nic-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
  lifecycle {
    ignore_changes = all
  }
}

resource "azurerm_windows_virtual_machine" "session_host" {
  count               = var.vm_count
  name                = "${var.vmhost_name}-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.session_host_nic[count.index].id
  ]

  identity {
    type = "SystemAssigned"
  }

  secure_boot_enabled = true
  vtpm_enabled        = true
  zone                = var.zone != null ? var.zone : tostring((count.index % 3) + 1)

  os_disk {
    caching                   = "ReadWrite"
    disk_size_gb              = 128
    storage_account_type      = "Premium_LRS"
    // disk_encryption_set_id    = azurerm_disk_encryption_set.avd_encryption_set.id
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-11"
    sku       = "win11-24h2-ent"
    version   = "latest"
  }

  additional_capabilities {
    hibernation_enabled = true
  }

  tags = {
    "Business.Application"     = "avd"
    "Business.EnvironmentType" = "prd"
    "Object.Region"            = "ae"
    "Project.code"             = "N.571.25.6795"
  }

  // depends_on = [
  //   azurerm_key_vault_access_policy.disk_encryption_policy
  // ]
  lifecycle {
    ignore_changes = all
  }
}

resource "azurerm_virtual_desktop_host_pool_registration_info" "avdtoken" {
  hostpool_id     = azurerm_virtual_desktop_host_pool.personal_pool.id
  expiration_date = timeadd(timestamp(), "24h")
  lifecycle {
    prevent_destroy = true
    ignore_changes = all
  }
}

resource "azurerm_virtual_machine_extension" "aad_login_for_windows" {
  count                      = var.vm_count
  name                       = "AADLoginForWindows"
  virtual_machine_id         = azurerm_windows_virtual_machine.session_host[count.index].id
  publisher                  = "Microsoft.Azure.ActiveDirectory"
  type                       = "AADLoginForWindows"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true

  settings = jsonencode({
    mdmId = "0000000a-0000-0000-c000-000000000000"
  })

  depends_on = [
    azurerm_windows_virtual_machine.session_host
  ]
 lifecycle {
    ignore_changes = all
  }
}

resource "azurerm_virtual_machine_extension" "entra_join" {
  count                = var.vm_count
  name                 = "EntraJoinScript"
  virtual_machine_id   = azurerm_windows_virtual_machine.session_host[count.index].id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = jsonencode({
    commandToExecute = "dsregcmd /status"
  })

  depends_on = [
    azurerm_virtual_machine_extension.aad_login_for_windows
  ]
  lifecycle {
    ignore_changes = all
  }
}

// resource "null_resource" "avd_registration_delay" {
//   count = var.vm_count

//   # This creates the strict sequential dependency
//   triggers = {
//     previous = count.index == 0 ? "" : null_resource.avd_registration_delay[count.index - 1].id
//   }

//   provisioner "local-exec" {
//     # 60 seconds is safe; reduce to 45 or increase to 90 if you still hit throttling
//     command     = "Start-Sleep -Seconds 60"
//     interpreter = ["PowerShell", "-Command"]
//     # Or on Linux/macOS runners:
//     # command = "sleep 60"
//   }

//   # This is the important part you asked about
//   lifecycle {
//     ignore_changes = all
//   }
// }

resource "azurerm_virtual_machine_extension" "register_avd_host" {
  count                 = var.vm_count
  name                  = "register-session-host-avd"
  virtual_machine_id    = azurerm_windows_virtual_machine.session_host[count.index].id
  publisher             = "Microsoft.Powershell"
  type                  = "DSC"
  type_handler_version  = "2.73"

  settings = <<-SETTINGS
    {
      "modulesUrl": "${var.avd_register_session_host_modules_url}",
      "configurationFunction": "Configuration.ps1\\AddSessionHost",
      "properties": {
        "hostPoolName": "${azurerm_virtual_desktop_host_pool.personal_pool.name}",
        "aadJoin": true
      }
    }
  SETTINGS

  protected_settings = <<-PROTECTED_SETTINGS
    {
      "properties": {
        "registrationInfoToken": "${azurerm_virtual_desktop_host_pool_registration_info.avdtoken.token}"
      }
    }
  PROTECTED_SETTINGS
  
  depends_on = [
    azurerm_virtual_machine_extension.entra_join
  ]
  lifecycle {
    ignore_changes = all
  }
}


// resource "azurerm_virtual_machine_extension" "register_avd_host" {
//   count                = var.vm_count
//   name                 = "register-session-host-avd"
//   virtual_machine_id   = azurerm_windows_virtual_machine.session_host[count.index].id
//   publisher            = "Microsoft.Powershell"
//   type                 = "DSC"
//   type_handler_version = "2.83"                   # upgraded – supports Delayed mode

//   settings = <<-SETTINGS
//     {
//       "modulesUrl": "${var.avd_register_session_host_modules_url}",
//       "configurationFunction": "Configuration.ps1\\AddSessionHost",
//       "wmfVersion": "latest",
//       "privacy": {
//         "dataCollection": "disable"
//       },
//       "properties": {
//         "hostPoolName": "${azurerm_virtual_desktop_host_pool.personal_pool.name}",
//         "aadJoin": true,
//         "StartAgentAfterInstall": "Delayed"
//       }
//     }
//   SETTINGS

//   protected_settings = <<-PROTECTED_SETTINGS
//     {
//       "properties": {
//         "registrationInfoToken": "${azurerm_virtual_desktop_host_pool_registration_info.avdtoken.token}"
//       }
//     }
//   PROTECTED_SETTINGS

//   depends_on = [
//     azurerm_virtual_machine_extension.entra_join
//   ]

//   lifecycle {
//     ignore_changes = all
//   }
// }