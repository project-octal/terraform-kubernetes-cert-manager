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
        "app" = local.app
        "app.kubernetes.io/name" : var.name
        "app.kubernetes.io/instance" : var.instance_id
        "app.kubernetes.io/managed-by" : "terraform"
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
          name              = var.name
          image             = "${local.image_repository}/${var.image_name}:${var.image_tag}"
          image_pull_policy = var.image_pull_policy
          args = [
            "--v=2",
            "--secure-port=10250",
            "--tls-cert-file=/certs/tls.crt",
            "--tls-private-key-file=/certs/tls.key"
          ]
          liveness_probe {
            http_get {
              path   = "/livez"
              port   = 6080
              scheme = "HTTP"
            }
          }
          readiness_probe {
            http_get {
              path   = "/healthz"
              port   = "6080"
              scheme = "HTTP"
            }
          }
          env {
            name  = "POD_NAMESPACE"
            value = var.namespace
          }
          # TODO: Resources for webhook
          resources {}
          volume_mount {
            name       = "service-token"
            mount_path = "/var/run/secrets/kubernetes.io/serviceaccount/"
            read_only  = true
          }
          volume_mount {
            name       = "certs"
            mount_path = "/certs"
          }
        }
        volume {
          name = "service-token"
          secret {
            secret_name = kubernetes_service_account.service_account.default_secret_name
          }
        }
        volume {
          name = "certs"
          secret {
            secret_name = "cert-manager-webhook-tls"
          }
        }
      }
    }
  }
}