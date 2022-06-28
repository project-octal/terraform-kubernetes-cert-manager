module "custom_resource_definitions" {
  source = "./custom-resource-definitions"
}

module "cert_manager_cainjector" {
  source = "./cert-manager-cainjector"

  depends_on = [module.custom_resource_definitions]

  instance_id       = local.instance_id
  namespace         = kubernetes_namespace.namespace.metadata.0.name
  image_tag         = var.cainjector_image_tag
  image_name        = var.cainjector_image_name
  image_repository  = var.image_repository
  image_pull_policy = var.image_pull_policy
  labels            = local.labels
}

locals {
  eks_role_annotation = {
    "eks.amazonaws.com/role-arn" = var.certificate_issuers.letsencrypt["solvers"]["dns01"]["route53"]["role"]
  }
  # eks_role_annotation = !lookup(var.certificate_issuers.letsencrypt, "solvers", false) ? null : !lookup(var.certificate_issuers.letsencrypt["solvers"], "dns01", false) ? null :
  # !lookup(var.certificate_issuers.letsencrypt["solvers"]["dns01"], "route53", false) ? null :
  # {eks.amazonaws.com/role-arn = var.certificate_issuers.letsencrypt["solvers"]["dns01"]["route53"]["role"]}
}

module "cert_manager" {
  source = "./cert-manager"

  depends_on = [module.custom_resource_definitions]

  name              = var.name
  instance_id       = local.instance_id
  namespace         = kubernetes_namespace.namespace.metadata.0.name
  image_tag         = var.manager_image_tag
  image_name        = var.manager_image_name
  image_repository  = var.image_repository
  image_pull_policy = var.image_pull_policy
  labels            = local.labels


  service_account_annotations = local.eks_role_annotation
  deployment_annotations      = local.eks_role_annotation
}

module "cert_manager_webhook" {
  source = "./cert-manager-webhook"

  depends_on = [module.custom_resource_definitions]

  instance_id       = local.instance_id
  namespace         = kubernetes_namespace.namespace.metadata.0.name
  image_tag         = var.webhook_image_tag
  image_name        = var.webhook_image_name
  image_repository  = var.image_repository
  image_pull_policy = var.image_pull_policy
  labels            = local.labels
}

module "cert_manager_issuers" {
  source = "./cert-manager-issuers"

  depends_on = [module.custom_resource_definitions]

  namespace   = kubernetes_namespace.namespace.metadata.0.name
  letsencrypt = var.certificate_issuers.letsencrypt
  # Others will go here...
}