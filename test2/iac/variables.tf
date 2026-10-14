variable "config_folder" {
  description = "Relative folder under iac/data where landing zone configurations are located.  All `yaml.tftpl' files in this folder will be processed."
  type        = string
  default     = null
}

variable "template_vars" {
  default  = {}
  nullable = false
}

# variable "appname" {
#   description = "Longer name of the application used for naming conventions."
#   type        = string
# }

# variable "short_appname" {
#   description = "Short name of the application used for naming conventions."
#   type        = string
#   validation {
#     # this is assuming that an environment name will be 4 characters or less - example for a storage account - st12345678901234prodae01
#     condition     = length(var.short_appname) <= 14
#     error_message = "Err: The short_appname should be 14 characters or less to fit within naming conventions for resources such as storage accounts."
#   }
# }

# variable "short_location_code" {
#   description = "A short form of the location where resource are deployed, used in naming conventions."
#   type        = string
#   default     = "ae"
# }

variable "environment" {
  description = "Name of the environment used for tagging (e.g. Dev, Test, UAT, Prod)."
  type        = string
  validation {
    condition = contains(
      ["Dev", "Test", "UAT", "Prod"],
      var.environment
    )
    error_message = "Err: environment should be one of Dev, Test, UAT, Prod."
  }
}

# variable "env_number" {
#   description = "This is the number for the default suffix naming standard for all resources. ie. 001"
#   type        = string
# }

# tags are expected to be provided
variable "default_tags" {
  description = <<DESCRIPTION
Tags to be applied to resources.  Default tags are expected to be provided in local.default_tags,
which is merged with environment specific ones in ``environments\env.terraform.tfvars``.
Most resources will simply apply the default tags like this:

```terraform
tags = local.default_tags
```

Additional tags can be provided by using a merge, for instance:

```terraform
tags = merge(
    local.default_tags,
    tomap({
      "MyExtraResourceTag" = "TheTagValue"
    })
)
```

Note you can also use the above mechanims to override or modify the default tags for an individual resource,
since only unique items in a map are retained, and later tags supplied to merge() function take precedence.
DESCRIPTION
  type        = map(string)
  default     = {}
}

# variable "key_vault_name" {
#   type        = string
#   description = "Name of key vault in core resource group"
# }
