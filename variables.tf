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

variable "enforce_ssl" {
  type        = bool
  default     = true
  description = "By default, traffic to this instance will be send using ssl via the rediss protocol. Toggle this option to false in order to use an unencrypted transport."
}
