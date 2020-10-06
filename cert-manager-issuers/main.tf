module "letsencrypt_issuer" {
  count = var.letsencrypt == null ? 0 : 1
  source = "./letsencrypt"
  email = var.letsencrypt.email
  ingress_class = var.letsencrypt.ingress_class
  labels = var.letsencrypt.labels
  name = var.letsencrypt.name
  server = var.letsencrypt.server
}