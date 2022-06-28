resource "kubernetes_deployment" "deployment" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels = merge({
      "app.kubernetes.io/name" = var.name
    }, local.labels)
    annotations = {}
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app                            = local.app
        "app.kubernetes.io/name"       = var.name
        "app.kubernetes.io/instance"   = var.instance_id
        "app.kubernetes.io/managed-by" = "terraform"
      }
    }
    template {
      metadata {
        name      = var.name
        namespace = var.namespace
        labels = merge({
          "app.kubernetes.io/name" = var.name
        }, local.labels)
        annotations = merge({
          "prometheus.io/path"   = "/metrics"
          "prometheus.io/scrape" = "true"
          "prometheus.io/port"   = "9402"
        }, var.deployment_annotations)
      }
      spec {
        service_account_name            = kubernetes_service_account.service_account.metadata.0.name
        automount_service_account_token = false
        security_context {
          fs_group = "1001"
        }
        container {
          name              = var.name
          image             = "${local.image_repository}/${var.image_name}:${var.image_tag}"
          image_pull_policy = var.image_pull_policy
          args = [
            "--v=2",
            "--cluster-resource-namespace=$(POD_NAMESPACE)",
            "--leader-election-namespace=kube-system"
          ]
          port {
            protocol       = "TCP"
            container_port = 9402
          }
          env {
            name  = "POD_NAMESPACE"
            value = var.namespace
          }

          resources {
            requests = {
              cpu    = "10m"
              memory = "32Mi"
            }
          }
          volume_mount {
            name       = "service-token"
            mount_path = "/var/run/secrets/kubernetes.io/serviceaccount/"
            read_only  = true
          }
        }
        volume {
          name = "service-token"
          secret {
            secret_name = kubernetes_service_account.service_account.default_secret_name
          }
        }
      }
    }
  }
}