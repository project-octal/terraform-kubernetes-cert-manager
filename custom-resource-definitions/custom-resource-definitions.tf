resource "k8s_manifest" "certificaterequests" {
  content = templatefile("certificaterequests.cert-manager.io.yml", {})
}
resource "k8s_manifest" "certificates" {
  content = templatefile("certificates.cert-manager.io.yml", {})
}
resource "k8s_manifest" "challenges" {
  content = templatefile("challenges.acme.cert-manager.io.yml", {})
}
resource "k8s_manifest" "clusterissuers" {
  content = templatefile("clusterissuers.cert-manager.io.yml", {})
}
resource "k8s_manifest" "issuers" {
  content = templatefile("issuers.cert-manager.io.yml", {})
}
resource "k8s_manifest" "orders" {
  content = templatefile("orders.acme.cert-manager.io.yml", {})
}