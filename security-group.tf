resource "aws_security_group" "this" {
  vpc_id = local.vpc_id
  name   = local.resource_name
  tags   = merge(data.ns_workspace.this.tags, { Name = local.resource_name })
}
