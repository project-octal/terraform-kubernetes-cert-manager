locals {
  labels = merge({
    "app" = "cainjector"
    "app.kubernetes.io/component" = var.component
    # Some more labels go here...
  }, var.labels)
}