output "db_admin_secret_id" {
  value       = aws_secretsmanager_secret.auth_token.id
  description = "string ||| The ID of the secret in AWS Secrets Manager containing the auth token"
}

output "db_protocol" {
  value       = aws_elasticache_replication_group.this.transit_encryption_enabled ? "rediss" : "redis"
  description = "string ||| This emits `redis` and is used for generalized data store contracts."
}

locals {
  single_endpoint  = format("%s:%s", try(aws_elasticache_replication_group.this.primary_endpoint_address, ""), local.port)
  cluster_endpoint = try(aws_elasticache_replication_group.this.configuration_endpoint_address, "")
}

output "db_endpoint" {
  value       = local.single_endpoint
  description = "string ||| The endpoint URL to access Redis."
}

output "db_security_group_id" {
  value       = aws_security_group.this.id
  description = "string ||| The ID of the security group attached to Redis."
}
