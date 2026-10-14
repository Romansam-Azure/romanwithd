# sitecore-xp-deployment/modules/sql/outputs.tf

output "sql_server_fqdn" {
  value = azurerm_mssql_server.sitecore_sql.fully_qualified_domain_name
}