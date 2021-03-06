resource "random_pet" "instance_name" {}
locals {
  name        = "cert-manager"
  instance_id = random_pet.instance_name.id
  labels = merge({
    "app.kubernetes.io/part-of"    = local.name
    "app.kubernetes.io/instance"   = local.instance_id
    "app.kubernetes.io/managed-by" = "terraform"
  }, var.labels)
}