resource "kubernetes_service_account" "service_account" {
  metadata {
    name        = var.name
    namespace   = var.namespace
    annotations = var.service_account_annotations
    labels = merge({
      "app.kubernetes.io/name" = var.name
    }, local.labels)
  }
}