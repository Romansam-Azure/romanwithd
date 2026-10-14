# Resource Groups rg-avd-p01-ae
module "rg_avd_p01_ae" {
  source   = "./modules/resource_group"
  name     = "rg-avd-p01-ae"
  location = "australiaeast"
  tags     = merge(local.common_tags, {
    "Business.Application" = "avd"
    "Object.ResourceType"  = "rg"
    "Object.Region"        = local.region_codes["australiaeast"]
  })
}

# Resource Groups rg-avd-p02-ae
module "rg_avd_p02_ae" {
  source   = "./modules/resource_group"
  name     = var.resource_group_name
  location = "australiaeast"
  tags     = merge(local.common_tags, {
    "Business.Application" = "avd"
    "Object.ResourceType"  = "rg"
    "Object.Region"        = local.region_codes["australiaeast"]
  })
}

# Resource Groups rg-avd-p03-ae
module "rg_avd_p03_ae" {
  source   = "./modules/resource_group"
  name     = "rg-avd-p03-ae"
  location = "australiaeast"
  tags     = merge(local.common_tags, {
    "Business.Application" = "avd"
    "Object.ResourceType"  = "rg"
    "Object.Region"        = local.region_codes["australiaeast"]
  })
}

# Resource Groups rg-avd-p05-ae
module "rg_avd_p05_ae" {
  source   = "./modules/resource_group"
  name     = "rg-avd-p05-ae"
  location = "australiaeast"
  tags     = merge(local.common_tags, {
    "Business.Application" = "avd"
    "Object.ResourceType"  = "rg"
    "Object.Region"        = local.region_codes["australiaeast"]
  })
}

# Resource Groups rg-avd-p04-ae
module "rg_avd_p04_ae" {
  source   = "./modules/resource_group"
  name     = "rg-avd-p04-ae"
  location = "australiaeast"
  tags     = merge(local.common_tags, {
    "Business.Application" = "avd"
    "Object.ResourceType"  = "rg"
    "Object.Region"        = local.region_codes["australiaeast"]
  })
}

# Resource Groups rg-avd-u01-ae
module "rg_avd_u01_ae" {
  source   = "./modules/resource_group"
  name     = "rg-avd-u01-ae"
  location = "australiaeast"
  tags     = merge(local.common_tags, {
    "Business.Application" = "avd"
    "Object.ResourceType"  = "rg"
    "Object.Region"        = local.region_codes["australiaeast"]
  })
}

# Resource Groups rg-avd-networking-p01-ae
module "rg_avd_networking_p01_ae" {
  source   = "./modules/resource_group"
  name     = "rg-avd-networking-p01-ae"
  location = "australiaeast"
  tags     = merge(local.common_tags, {
    "Business.Application" = "Virtual Networking"
    "Object.ResourceType"  = "rg"
    "Object.Region"        = local.region_codes["australiaeast"]
    "ResourceGroup.Lock " =  "Enabled"
  })
}


#Australis South East Resource Groups 

# Resource Groups rg-avd-p01-ase
module "rg_avd_p01_ase" {
  source   = "./modules/resource_group"
  name     = "rg-avd-p01-ase"
  location = "australiasoutheast"
  tags     = merge(local.common_tags, {
    "Business.Application" = "avd"
    "Object.ResourceType"  = "rg"
    "Object.Region"        = local.region_codes["australiasoutheast"]
  })
}

# Resource Groups rg-avd-p02-ase
module "rg_avd_p02_ase" {
  source   = "./modules/resource_group"
  name     = "rg-avd-p02-ase"
  location = "australiasoutheast"
  tags     = merge(local.common_tags, {
    "Business.Application" = "avd"
    "Object.ResourceType"  = "rg"
    "Object.Region"        = local.region_codes["australiasoutheast"]
  })
}

# Resource Groups rg-avd-p03-ase
module "rg_avd_p03_ase" {
  source   = "./modules/resource_group"
  name     = "rg-avd-p03-ase"
  location = "australiasoutheast"
  tags     = merge(local.common_tags, {
    "Business.Application" = "avd"
    "Object.ResourceType"  = "rg"
    "Object.Region"        = local.region_codes["australiasoutheast"]
  })
}

# Resource Groups rg-avd-p04-ase
module "rg_avd_p04_ase" {
  source   = "./modules/resource_group"
  name     = "rg-avd-p04-ase"
  location = "australiasoutheast"
  tags     = merge(local.common_tags, {
    "Business.Application" = "avd"
    "Object.ResourceType"  = "rg"
    "Object.Region"        = local.region_codes["australiasoutheast"]
  })
}

# Resource Groups rg-avd-p05-ase
module "rg_avd_p05_ase" {
  source   = "./modules/resource_group"
  name     = "rg-avd-p05-ase"
  location = "australiasoutheast"
  tags     = merge(local.common_tags, {
    "Business.Application" = "avd"
    "Object.ResourceType"  = "rg"
    "Object.Region"        = local.region_codes["australiasoutheast"]
  })
}

# Resource Groups rg-avd-networking-p01-ase
module "rg_avd_networking_p01_ase" {
  source   = "./modules/resource_group"
  name     = "rg-avd-networking-p01-ase"
  location = "australiasoutheast"
  tags     = merge(local.common_tags, {
    "Business.Application" = "Virtual Networking"
    "Object.ResourceType"  = "rg"
    "Object.Region"        = local.region_codes["australiasoutheast"]
    "ResourceGroup.Lock " =  "Enabled"
  })
}