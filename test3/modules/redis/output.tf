# sitecore-xp-deployment/modules/redis/outputs.tf

output "redis_cache_hostname" {
  value = azurerm_redis_cache.sitecore_redis.hostname
}