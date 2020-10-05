locals {
  labels = merge({
    "app" = "cert-manager"
    "app.kubernetes.io/component" = var.component
    # Some more labels go here...
  }, var.labels)
}