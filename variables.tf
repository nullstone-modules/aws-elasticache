variable "redis_version" {
  type        = string
  default     = "6.x"
  description = "Redis engine version"
}

variable "node_type" {
  type        = string
  default     = "cache.t3.small"
  description = "The node size for each redis node. See https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/CacheNodes.SupportedTypes.html."
}

variable "node_count" {
  type        = number
  default     = 1
  description = "The number of nodes to provision in the redis cluster. By default, this runs with minimally with 1 node."
}

variable "node_group_count" {
  type        = number
  default     = 0
  description = "The number of node groups (shards) to provision. By default, configured with 0 which disables cluster mode."
}

variable "replicas_per_node" {
  type        = number
  default     = 1
  description = "Number of replica nodes in each node group. Valid values are 0 to 5."
}
