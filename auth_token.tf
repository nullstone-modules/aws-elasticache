// Auth Tokens for redis must be:
//  - 16-128 printable characters
//  - Alphanumeric, !, &, #, $, ^, <, >, -
resource "random_password" "auth_token" {
  length  = 24
  special = true

  // The password for the master database user can include any printable ASCII character except /, ", @, or a space.
  override_special = "!&#$^<>-"
}

resource "aws_secretsmanager_secret" "auth_token" {
  name = "${local.resource_name}/auth_token"
  tags = local.tags

  count = local.has_auth_token ? 1 : 0
}

resource "aws_secretsmanager_secret_version" "auth_token" {
  secret_id     = aws_secretsmanager_secret.auth_token[count.index].id
  secret_string = local.auth_token

  count = local.has_auth_token ? 1 : 0
}
