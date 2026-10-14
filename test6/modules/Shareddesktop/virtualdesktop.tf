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

resource "azurerm_virtual_desktop_host_pool" "pooled_pool" {
  name                             = var.host_pool_name
  location                         = var.location
  resource_group_name              = var.resource_group_name
  type                             = "Pooled"
  load_balancer_type               = "DepthFirst"
  preferred_app_group_type         = "Desktop"
  friendly_name                    = var.friendly_name
  validate_environment             = true
  start_vm_on_connect              = true

  //  targetisaadjoined:i:1;  redirectclipboard:i:1; removed

custom_rdp_properties = "enablerdsaadauth:i:1;enablecredsspsupport:i:1;redirectprinters:i:0;redirectcomports:i:0;redirectsmartcards:i:0;redirectwebauthn:i:1;drivestoredirect:s:;devicestoredirect:s:;usbdevicestoredirect:s:;camerastoredirect:s:;audiomode:i:0;audiocapturemode:i:0;encode redirected video capture:i:1;redirected video capture encoding quality:i:0;videoplaybackmode:i:1;use multimon:i:1;smart sizing:i:1;dynamic resolution:i:1;desktopwidth:i:0;desktopheight:i:0;screen mode id:i:2;desktopscalefactor:i:0;span monitors:i:1;autoreconnection enabled:i:1;enableworkspacereconnect:i:1;bandwidthautodetect:i:1;networkautodetect:i:1;compression:i:1;disable wallpaper:i:1;allow font smoothing:i:1;allow desktop composition:i:1;disable full window drag:i:1;disable menu anims:i:1;disable themes:i:1;disable cursor setting:i:0;singlemoninwindowedmode:i:1;"


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

resource "azurerm_virtual_desktop_application_group" "remoteapp" {
  name                = var.applicationgroupname
  location            = var.location
  resource_group_name = var.resource_group_name
  host_pool_id        = azurerm_virtual_desktop_host_pool.pooled_pool.id
  type                = "RemoteApp"
  friendly_name       = "${var.applicationgroupname}-rag"
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

resource "azurerm_virtual_desktop_application" "dr_kronos" {
  name                         = "drkronos"
  application_group_id         = azurerm_virtual_desktop_application_group.remoteapp.id
  friendly_name                = "DR Kronos"
  description                  = "DR Kronos"
  path                         = "C:\\Program Files\\DRKronos\\Application\\DRKronos.exe"
  command_line_argument_policy = "DoNotAllow"
}

resource "azurerm_virtual_desktop_application" "onbase" {
  name                         = "onbase"
  application_group_id         = azurerm_virtual_desktop_application_group.remoteapp.id
  friendly_name                = "OnBase"
  description                  = "OnBase"
  path                         = "C:\\Program Files\\OnBase\\Application\\OnBase.exe"
  command_line_argument_policy = "DoNotAllow"
}

resource "azurerm_virtual_desktop_application" "onbase_client" {
  name                         = "onbaseclient"
  application_group_id         = azurerm_virtual_desktop_application_group.remoteapp.id
  friendly_name                = "OnBaseClient"
  description                  = "OnBaseClient"
  path                         = "C:\\Program Files\\OnBaseClient\\Application\\OnBaseClient.exe"
  command_line_argument_policy = "DoNotAllow"
}

resource "azurerm_virtual_desktop_application" "onyx" {
  name                         = "onyx"
  application_group_id         = azurerm_virtual_desktop_application_group.remoteapp.id
  friendly_name                = "Onyx"
  description                  = "Onyx"
  path                         = "C:\\Program Files\\Onyx\\Application\\Onyx.exe"
  command_line_argument_policy = "DoNotAllow"
}

data "azuread_group" "example_group" {
  display_name = var.aad_group_display_name  # your AAD group name here
}

resource "azurerm_role_assignment" "desktop_virtualization_user" {
  scope                          = azurerm_virtual_desktop_application_group.remoteapp.id
  role_definition_name            = "Desktop Virtualization User"
  principal_id                    = data.azuread_group.example_group.id
  skip_service_principal_aad_check = true
  lifecycle {
    ignore_changes = all
  }
}


locals {
  workspace_id = var.existing_workspace_id
}

resource "azurerm_virtual_desktop_workspace_application_group_association" "association" {
  application_group_id = azurerm_virtual_desktop_application_group.remoteapp.id
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
  zone = tostring((count.index % 3) + 1)

  os_disk {
    caching              = "ReadWrite"
    disk_size_gb         = 128
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-11"
    sku       = "win11-24h2-ent"
    version   = "latest"
  }

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

resource "azurerm_virtual_desktop_host_pool_registration_info" "shdtoken" {
  hostpool_id     = azurerm_virtual_desktop_host_pool.pooled_pool.id
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
    mdmId = "0000000a-0000-0000-c000-000000000000"  # <- Microsoft Intune MDM ID
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
        "hostPoolName": "${azurerm_virtual_desktop_host_pool.pooled_pool.name}",
        "aadJoin": true
      }
    }
  SETTINGS

  protected_settings = <<-PROTECTED_SETTINGS
    {
      "properties": {
        "registrationInfoToken": "${azurerm_virtual_desktop_host_pool_registration_info.shdtoken.token}"
      }
    }
  PROTECTED_SETTINGS

  depends_on = [azurerm_virtual_machine_extension.aad_login_for_windows]
  lifecycle {
    ignore_changes = all
  }
}
