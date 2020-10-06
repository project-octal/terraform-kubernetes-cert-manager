resource "kubernetes_cluster_role" "cluster_role" {
  metadata {
    name = "${var.name}:webhook-requester"
    labels = merge({
      "app.kubernetes.io/name" = var.name
    }, local.labels)
  }
  rule {
    api_groups = ["admission.cert-manager.io"]
    resources = [
      "certificates",
      "certificaterequests",
      "issuers",
      "clusterissuers"
    ]
    verbs = ["create"]
  }
}