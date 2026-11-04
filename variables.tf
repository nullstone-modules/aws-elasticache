variable "redis_version" {
  type        = string
  default     = "8.0"
  description = <<-EOF
    The engine version for the ElastiCache replication group.
    Versions 7.x and below use the Redis engine.
    Versions 8.0 and above use the Valkey engine.
  EOF
}

variable "node_type" {
  type        = string
  default     = "cache.t3.small"
  description = "The node size for each redis node. See https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/CacheNodes.SupportedTypes.html."
}

variable "enforce_ssl" {
  type        = bool
  default     = true
  description = "By default, traffic to this instance will be sent using ssl via the rediss protocol. Toggle this option off in order to use an unencrypted transport."
}

variable "multi_az" {
  type        = bool
  default     = false
  description = "Enable Multi-AZ with automatic failover. When the primary fails, AWS promotes a replica and moves the primary endpoint within about a minute. Requires at least one replica. Not supported on cache.t2 node types."

  validation {
    condition     = !var.multi_az || var.num_replicas >= 1
    error_message = "multi_az requires num_replicas >= 1."
  }
}

variable "num_replicas" {
  type        = number
  default     = 1
  description = "Number of read replicas. The reader endpoint round-robins across them. Set to 0 for a single-node cluster (no reader endpoint, no failover)."
}
