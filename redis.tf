resource "aws_elasticache_cluster" "this" {
  cluster_id           = local.resource_name
  replication_group_id = aws_elasticache_replication_group.this.id
  tags                 = local.tags
}

locals {
  port = 6379
}

resource "aws_elasticache_subnet_group" "this" {
  name       = local.resource_name
  subnet_ids = coalescelist(local.private_subnet_ids, local.public_subnet_ids)
  tags       = local.tags
}

resource "aws_elasticache_replication_group" "this" {
  replication_group_id       = local.resource_name
  description                = "${local.resource_name} - Managed via Nullstone"
  tags                       = local.tags
  auto_minor_version_upgrade = true
  at_rest_encryption_enabled = true
  transit_encryption_enabled = var.enforce_ssl
  auth_token                 = local.auth_token
  engine                     = "redis"
  engine_version             = var.redis_version
  node_type                  = var.node_type
  port                       = local.port
  security_group_ids         = [aws_security_group.this.id]
  subnet_group_name          = aws_elasticache_subnet_group.this.name
  multi_az_enabled           = false
  automatic_failover_enabled = false
  num_cache_clusters         = 2
  apply_immediately          = true
}

locals {
  // when transit_encrypt_enabled is false, we can't provide an auth_token
  // see the usage of this local above for context
  has_auth_token = var.enforce_ssl ? true : false
  auth_token     = local.has_auth_token ? random_password.auth_token.result : null
}
