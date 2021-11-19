resource "aws_elasticache_cluster" "this" {
  cluster_id           = local.resource_name
  replication_group_id = aws_elasticache_replication_group.this.id
}

locals {
  port          = 6379
  is_multi_node = var.node_count > 1
  cluster_mode  = var.node_group_count > 0 ? [{ groups = var.node_group_count, replicas = var.replicas_per_node }] : []
}

resource "aws_elasticache_subnet_group" "this" {
  name       = local.resource_name
  subnet_ids = local.private_subnet_ids
  tags       = data.ns_workspace.this.tags
}

resource "aws_elasticache_replication_group" "this" {
  replication_group_id          = local.resource_name
  replication_group_description = "${local.resource_name} - Managed via Nullstone"
  tags                          = data.ns_workspace.this.tags
  auto_minor_version_upgrade    = true
  at_rest_encryption_enabled    = true
  transit_encryption_enabled    = true
  auth_token                    = random_password.auth_token.result
  engine                        = "redis"
  engine_version                = var.redis_version
  node_type                     = var.node_type
  port                          = local.port
  security_group_ids            = [aws_security_group.this.id]
  subnet_group_name             = aws_elasticache_subnet_group.this.name
  multi_az_enabled              = length(local.private_subnet_ids) > 1 && local.is_multi_node
  automatic_failover_enabled    = local.is_multi_node
  number_cache_clusters         = var.node_count
  apply_immediately             = true

  dynamic "cluster_mode" {
    for_each = local.cluster_mode

    content {
      num_node_groups         = cluster_mode.value.groups
      replicas_per_node_group = cluster_mode.value.replicas
    }
  }
}
