resource "kubernetes_role" "role" {
  metadata {
    name      = "${var.name}:leaderelection"
    namespace = "kube-system"
    labels = merge({
      "app.kubernetes.io/name" = var.name
    }, local.labels)
  }

  rule {
    api_groups = ["coordination.k8s.io"]
    resources = [
      "leases"
    ]
    verbs = ["get", "create", "update", "patch"]
  }
}