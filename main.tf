module "custom_resource_definitions" {
  source = "./custom-resource-definitions"
}

module "cert_manager_cainjector" {
  source = "./cert-manager-cainjector"
  namespace = kubernetes_namespace.namespace.metadata.0.name
  image_repository = var.image_repository
  image_pull_policy = var.image_pull_policy
  labels = local.labels
}

module "cert_manager" {
  source = "./cert-manager"
  namespace = kubernetes_namespace.namespace.metadata.0.name
  image_repository = var.image_repository
  image_pull_policy = var.image_pull_policy
  labels = local.labels
}

module "cert_manager_webhook" {
  source = "./cert-manager-webhook"
  namespace = kubernetes_namespace.namespace.metadata.0.name
  image_repository = var.image_repository
  image_pull_policy = var.image_pull_policy
  labels = local.labels
}