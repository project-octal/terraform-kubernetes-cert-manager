# This will be a decision tree. I should probably chop it down before it grows too large...
output "default_issuer" {
  value = lookup(var.letsencrypt, "default_issuer", false) ? var.letsencrypt.name : ""
  # lookup(local.foocrypt, "default_issuer", false) ? var.foocrypt.name : ""
}

module "letsencrypt_issuer" {
  source = "./letsencrypt"

  count       = var.letsencrypt == null ? 0 : 1
  namespace   = var.namespace
  letsencrypt = var.letsencrypt
}