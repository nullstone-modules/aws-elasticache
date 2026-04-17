# 0.3.0 (Apr 17, 2026)
* Fixed Valkey support by removing redundant `aws_elasticache_cluster` resource for valkey. The `CreateCacheCluster` API does not support Valkey; the replication group already manages its own cache nodes via `num_cache_clusters`.
* **Note**: Existing deployments will see a plan to destroy `aws_elasticache_cluster.this`. Run `terraform state rm aws_elasticache_cluster.this` beforehand to avoid an unnecessary destroy/recreate cycle.

# 0.2.0 (Mar 30, 2026)
* Added support for Valkey. (set `redis_version >= 8.0`)
