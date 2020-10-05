module "custom_resource_definitions" {
  source = "./custom-resource-definitions"
}

module "cert_manager_cainjector" {
  source = "./cert-manager-cainjector"

  instance_id = local.instance_id
  namespace = kubernetes_namespace.namespace.metadata.0.name
  image_repository = var.image_repository
  image_pull_policy = var.image_pull_policy
  labels = local.labels
}

module "cert_manager" {
  source = "./cert-manager"

  instance_id = local.instance_id
  namespace = kubernetes_namespace.namespace.metadata.0.name
  image_repository = var.image_repository
  image_pull_policy = var.image_pull_policy
  labels = local.labels
}

module "cert_manager_webhook" {
  source = "./cert-manager-webhook"

  instance_id = local.instance_id
  namespace = kubernetes_namespace.namespace.metadata.0.name
  image_repository = var.image_repository
  image_pull_policy = var.image_pull_policy
  labels = local.labels
}