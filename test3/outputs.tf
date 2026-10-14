# sitecore-xp-deployment/outputs.tf

output "sql_server_fqdn" {
  description = "Fully qualified domain name of the SQL Server"
  value       = module.sql.sql_server_fqdn
}

output "app_service_urls" {
  description = "URLs of deployed App Services"
  value       = module.app_service.app_service_urls
}

output "service_bus_namespace" {
  description = "Azure Service Bus namespace"
  value       = module.service_bus.namespace_name
}

output "redis_cache_hostname" {
  description = "Redis Cache hostname"
  value       = module.redis.redis_cache_hostname
}

output "app_insights_instrumentation_key" {
  description = "Application Insights instrumentation key"
  value       = module.app_insights.instrumentation_key
  sensitive = true
}

output "oms_workspace_id" {
  description = "OMS Workspace ID"
  value       = module.oms.workspace_id
}