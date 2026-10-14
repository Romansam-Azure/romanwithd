variable "host_pool_name" {}
variable "friendly_name" {}
variable "location" {}
variable "resource_group_name" {}
variable "applicationgroupname" {}
variable "subnet_id" {}
variable "vm_count" { type = number }
variable "vm_size" {}
variable "admin_username" {}
variable "admin_password" { sensitive = true }
variable "vmhost_name" {}

variable "existing_workspace_id" {
  type        = string
  description = "Workspace ID to associate with if create_workspace is false"
  default     = ""
}

variable "aad_group_display_name" {
  description = "Display name of the Azure AD group to assign to the application group"
  type        = string
  default     = ""
}


variable "avd_register_session_host_modules_url" {
  type        = string
  description = "URL to .zip file containing DSC configuration to register AVD session hosts to AVD host pool."
  default     = "https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration_02-23-2022.zip"
}