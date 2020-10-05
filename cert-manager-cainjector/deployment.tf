resource "kubernetes_deployment" "deployment" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels = merge({
      "app.kubernetes.io/name" = var.name
    }, local.labels)
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app: local.app
        app.kubernetes.io/name: var.name
        app.kubernetes.io/instance: var.instance_id
        app.kubernetes.io/managed-by: "terraform"
      }
    }
    template {
      metadata {
        name      = var.name
        namespace = var.namespace
        labels = merge({
          "app.kubernetes.io/name" = var.name
        }, local.labels)
      }
      spec {
        service_account_name = kubernetes_service_account.service_account.metadata.0.name
        container {
          name = var.name
          image             = "${var.image_repository}/${var.image_name}:${var.image_tag}"
          image_pull_policy = var.image_pull_policy
          args = [
            "--v=2",
            "--leader-election-namespace=kube-system"
          ]
          env {
            name = "POD_NAMESPACE"
            value_from {
              field_ref {
                field_path = "metadata.namespace"
              }
            }
          }
          # TODO: Resources for cainjector
          resources {}
        }
      }
    }
  }
}