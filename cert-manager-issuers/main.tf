module "letsencrypt_issuer" {
  source = "./letsencrypt"

  count = var.letsencrypt == null ? 0 : 1

  namespace = var.namespace
  name = var.letsencrypt.name
  server = var.letsencrypt.server
  email = var.letsencrypt.email
  secret_base64_key = var.letsencrypt.secret_base64_key
  ingress_class = var.letsencrypt.ingress_class
}