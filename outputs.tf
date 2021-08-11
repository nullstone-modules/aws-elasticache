output "db_admin_secret_name" {
  value       = aws_secretsmanager_secret.auth_token.name
  description = "string ||| The name of the secret in AWS Secrets Manager containing the auth token"
}

output "db_protocol" {
  value       = "redis"
  description = "string ||| This emits `redis` and is used for generalized data store contracts."
}

locals {
  single_endpoint  = try(aws_elasticache_replication_group.this.primary_endpoint_address, "")
  cluster_endpoint = try(aws_elasticache_replication_group.this.configuration_endpoint_address, "")
}

output "db_endpoint" {
  // There are 2 different endpoints exported based on whether cluster mode is enabled
  value       = var.node_group_count > 0 ? local.cluster_endpoint : local.single_endpoint
  description = "string ||| The endpoint URL to access Redis."
}

output "db_security_group_id" {
  value       = aws_security_group.this.id
  description = "string ||| The ID of the security group attached to Redis."
}