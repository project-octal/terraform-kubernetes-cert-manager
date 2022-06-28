resource "kubernetes_secret" "letsencrypt_issuer_secret" {
  metadata {
    name      = var.letsencrypt.name
    namespace = var.namespace
  }
  data = {
    # We decode it before injecting it because the provider will re-encode it.
    "tls.key" = base64decode(var.letsencrypt.secret_base64_key)
  }
}

resource "kubernetes_manifest" "letsencrypt_issuer" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"
    metadata = {
      name = var.letsencrypt.name
      labels = {
        name = var.letsencrypt.name
      }
    }
    spec = {
      acme = {
        server = var.letsencrypt.server
        email  = var.letsencrypt.email
        privateKeySecretRef = {
          name = kubernetes_secret.letsencrypt_issuer_secret.metadata.0.name
        }
        solvers = local.enabled_solvers
      }
    }
  }
}