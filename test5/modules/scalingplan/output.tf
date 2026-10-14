output "scaling_plan_id" {
  description = "The full ARM ID of the created scaling plan"
  value       = try(azapi_resource.scaling_plan_personal[0].id, null)
}

output "scaling_plan_name" {
  description = "The name of the scaling plan"
  value       = try(azapi_resource.scaling_plan_personal[0].name, null)
}