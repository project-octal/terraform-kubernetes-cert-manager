locals {
  mutating_webhook_configuration = {
    "apiVersion" = "admissionregistration.k8s.io/v1beta1"
    "kind" = "MutatingWebhookConfiguration"
    "metadata" = {
      "name" = var.name

      "labels" = merge({
        "app.kubernetes.io/name" = var.name
      }, local.labels)
      annotations = {
        "cert-manager.io/inject-ca-from-secret" = "cert-manager/cert-manager-webhook-tls"
      }
    }
    "webhooks" = {
      "name" = "webhook.cert-manager.io"
      "rules" = [
        {
          apiGroups = ["cert-manager.io", "acme.cert-manager.io"]
          apiVersions = ["v1alpha2"]
          operations = ["CREATE", "UPDATE"]
          resources = ["*/*"]
        }
      ]
      failurePolicy = "Fail"
      sideEffects = "None"
      clientConfig = {
        service = {
          name = var.name
          namespace = var.namespace
          path = "/mutate"
        }
      }
    }
  }
}