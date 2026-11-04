# aws-elasticache

Creates a managed redis cluster following best practices using AWS Elasticache.

## Variables

| Name | Default | Description |
|------|---------|-------------|
| `redis_version` | `"8.0"` | Engine version. 7.x and below run Redis; 8.0 and above run Valkey. |
| `node_type` | `"cache.t3.small"` | Node size for every node in the group. |
| `enforce_ssl` | `true` | Use TLS (`rediss`). Turning this off also disables the auth token. |
| `multi_az` | `false` | Enable Multi-AZ with automatic failover. When the primary fails, AWS promotes a replica and moves the primary endpoint within about a minute. Requires `num_replicas >= 1`. Not supported on `cache.t2` node types. |
| `num_replicas` | `1` | Number of read replicas. The reader endpoint round-robins across them. `0` gives a single node: no reader endpoint, no failover. |

## Multi-AZ and replicas

Changing `multi_az` or `num_replicas` on an existing deployment is an in-place modify of the replication group, not a replacement. No data is lost and the primary endpoint does not change.

Multi-AZ adds no charge beyond the nodes themselves. Each replica is one more node of `node_type`.

Set `num_replicas: 0` for a cheap single-node cache. `reader_host` is `""` in that case.
