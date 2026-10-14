variable "host_pool_name" {}
variable "friendly_name" {}
variable "location" {}
variable "resource_group_name" {}
variable "subnet_id" {}
variable "vm_count" { type = number }
variable "vm_size" {}
variable "admin_username" {}
variable "vm_name" {
  type    = string
  default = ""
  description = "VM Name"
}
variable "admin_password" { sensitive = true }

variable "create_workspace" {
  type    = bool
  default = true
}

variable "existing_workspace_id" {
  type    = string
  default = ""
}


variable "avd_register_session_host_modules_url" {
  type        = string
  description = "URL to .zip file containing DSC configuration to register AVD session hosts to AVD host pool."
  default     = "https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration_02-23-2022.zip"
}

// variable "existing_scaling_plan_id" {
//   type    = string
//   default = ""
//   description = "ID of existing scaling plan to attach the host pool to"
// }

// variable "enable_scaling_plan" {
//   type    = bool
//   default = false
//   description = "Set to true to create scaling plan inside module (not recommended if already have one)"
// }


// variable "attach_existing_scaling_plan" {
//   description = "Set to true to attach the host pool to an existing scaling plan"
//   type        = bool
//   default     = false
// }
