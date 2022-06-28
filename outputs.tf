output "namespace" {
  value = kubernetes_namespace.namespace.metadata.0.name
}
output "cert_manager_service_account" {
  value = module.cert_manager.service_account
}
output "cert_issuer" {
  # The issuer is only output once it's ready to issue certs.
  # (Prevent race condition)
  depends_on = [
    module.custom_resource_definitions,
    module.cert_manager_cainjector,
    module.cert_manager,
    module.cert_manager_webhook,
    module.cert_manager_issuers
  ]
  value = module.cert_manager_issuers.default_issuer
}