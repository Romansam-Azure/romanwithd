# appname       = "stutest"
# short_appname = "stutest"

# env_number    = "01" ## usual is 001 but stutest is 01

environment = "Dev"

config_folder = "./environments/examples/app1"

default_tags = {
  ApplicationName = "app1 VM demo"
  ChargeCode      = "12631-173980-142"
  OwnerTeam       = "Infrastructure Products"
}

template_vars = {
  location            = "australiaeast"
  resource_group_name = "rg-app1-pom-aue-001"
}
