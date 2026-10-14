locals {

  config_base_dir = "${path.root}/${var.config_folder}"
  config_files    = fileset(local.config_base_dir, "*.tftpl.yaml")

  # lz_settings takes each file, applies variables from var.template_vars, and merges them into a single map
  config_map = {
    for f in local.config_files :
    replace(split(".", f)[0], "/", "-") => yamldecode(templatefile("${local.config_base_dir}/${f}", var.template_vars))
  }

  env_code = lower(var.environment)

  default_tags = merge(
    var.default_tags,
    tomap({
      "Environment" = var.environment
    })
  )
}
