resource "kubernetes_namespace" "namespace" {
  metadata {
    name        = var.namespace
    labels      = local.labels
    annotations = var.namespace_annotations
  }
}