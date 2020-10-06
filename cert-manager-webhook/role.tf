resource "kubernetes_role" "role" {
  metadata {
    name      = "${var.name}:dynamic-serving"
    namespace = "kube-system"
    labels = merge({
      "app.kubernetes.io/name" = var.name
    }, local.labels)
  }
  rule {
    api_groups = [""]
    resources = [
      "secrets"
    ]
    verbs = ["create"]
  }
  rule {
    api_groups = [""]
    resource_names = [
      "cert-manager-webhook-ca"
    ]
    resources = [
      "secrets"
    ]
    verbs = ["get", "list", "watch", "update"]
  }
}