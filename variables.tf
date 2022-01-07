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
