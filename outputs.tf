output "db_admin_secret_id" {
  value       = try(aws_secretsmanager_secret.auth_token[0].id, "")
  description = "string ||| The ID of the secret in AWS Secrets Manager containing the auth token"
}

output "db_protocol" {
  value       = aws_elasticache_replication_group.this.transit_encryption_enabled ? "rediss" : "redis"
  description = "string ||| This emits `rediss` (secure) or `redis` and is used for generalized data store contracts."
}

locals {
  single_endpoint  = format("%s:%s", try(aws_elasticache_replication_group.this.primary_endpoint_address, ""), local.port)
  cluster_endpoint = try(aws_elasticache_replication_group.this.configuration_endpoint_address, "")
}

output "db_endpoint" {
  value       = coalesce(local.single_endpoint, local.cluster_endpoint)
  description = "string ||| The endpoint URL to access Redis."
}

output "db_security_group_id" {
  value       = aws_security_group.this.id
  description = "string ||| The ID of the security group attached to Redis."
}

output "primary_host" {
  value       = aws_elasticache_replication_group.this.primary_endpoint_address
  description = "string ||| The primary redis host for writes and reads"
}

output "reader_host" {
  value       = aws_elasticache_replication_group.this.reader_endpoint_address
  description = "string ||| The primary redis host for reads"
}
