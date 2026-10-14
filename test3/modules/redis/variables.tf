# sitecore-xp-deployment/modules/redis/variables.tf

variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "redis_cache_name" { type = string }
variable "sitecore_sku" { type = string }