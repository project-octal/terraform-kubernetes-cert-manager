resource "kubernetes_cluster_role" "issuers_cluster_role" {
  metadata {
    name = "${var.name}-controller-issuers"
    labels = merge({
      "app.kubernetes.io/name" = var.name
    }, local.labels)
  }
  rule {
    api_groups = ["cert-manager.io"]
    resources = [
      "issuers",
      "issuers/status"
    ]
    verbs = ["update"]
  }
  rule {
    api_groups = ["cert-manager.io"]
    resources = [
      "issuers"
    ]
    verbs = ["get", "list", "watch"]
  }
  rule {
    api_groups = [""]
    resources = [
      "secrets"
    ]
    verbs = ["get", "list", "watch", "create", "patch", "update", "delete"]
  }
  rule {
    api_groups = [""]
    resources = [
      "events"
    ]
    verbs = ["create", "patch"]
  }
}

resource "kubernetes_cluster_role" "clusterissuers_cluster_role" {
  metadata {
    name = "${var.name}-controller-clusterissuers"
    labels = merge({
      "app.kubernetes.io/name" = var.name
    }, local.labels)
  }

  rule {
    api_groups = ["cert-manager.io"]
    resources = [
      "clusterissuers",
      "clusterissuers/status"
    ]
    verbs = ["update"]
  }
  rule {
    api_groups = ["cert-manager.io"]
    resources = [
      "clusterissuers"
    ]
    verbs = ["get", "list", "watch"]
  }
  rule {
    api_groups = [""]
    resources = [
      "secrets"
    ]
    verbs = ["get", "list", "watch", "create", "update", "delete"]
  }
  rule {
    api_groups = [""]
    resources = [
      "events"
    ]
    verbs = ["create", "patch"]
  }
}

resource "kubernetes_cluster_role" "certificates_cluster_role" {
  metadata {
    name = "${var.name}-certificates"
    labels = merge({
      "app.kubernetes.io/name" = var.name
    }, local.labels)
  }
  rule {
    api_groups = ["cert-manager.io"]
    resources = [
      "certificates",
      "certificates/status",
      "certificaterequests",
      "certificaterequests/status"
    ]
    verbs = ["update"]
  }
  # We require these rules to support users with the OwnerReferencesPermissionEnforcement
  # admission controller enabled:
  # https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#ownerreferencespermissionenforcement
  rule {
    api_groups = ["cert-manager.io"]
    resources = [
      "certificates/finalizers",
      "certificaterequests/finalizers"
    ]
    verbs = ["get", "list", "watch"]
  }
  rule {
    api_groups = ["cert-manager.io"]
    resources = [
      "certificates/finalizers",
      "certificaterequests/finalizers"
    ]
    verbs = ["update"]
  }
  rule {
    api_groups = ["acme.cert-manager.io"]
    resources = [
      "orders"
    ]
    verbs = ["create", "delete", "get", "list", "watch"]
  }
  rule {
    api_groups = [""]
    resources = [
      "secrets"
    ]
    verbs = ["get", "list", "watch", "create", "update", "delete"]
  }
  rule {
    api_groups = [""]
    resources = [
      "events"
    ]
    verbs = ["create", "patch"]
  }
}

resource "kubernetes_cluster_role" "orders_cluster_role" {
  metadata {
    name = "${var.name}-controller-orders"
    labels = merge({
      "app.kubernetes.io/name" = var.name
    }, local.labels)
  }
  rule {
    api_groups = ["acme.cert-manager.io"]
    resources = [
      "orders",
      "orders/status"
    ]
    verbs = ["update"]
  }
  rule {
    api_groups = ["acme.cert-manager.io"]
    resources = [
      "orders",
      "challenges"
    ]
    verbs = ["get", "list", "watch"]
  }
  rule {
    api_groups = ["cert-manager.io"]
    resources = [
      "clusterissuers",
      "issuers"
    ]
    verbs = ["get", "list", "watch"]
  }
  rule {
    api_groups = ["acme.cert-manager.io"]
    resources = [
      "challenges"
    ]
    verbs = ["create", "delete"]
  }
  # We require these rules to support users with the OwnerReferencesPermissionEnforcement
  # admission controller enabled:
  # https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#ownerreferencespermissionenforcement
  rule {
    api_groups = ["acme.cert-manager.io"]
    resources = [
      "orders/finalizers"
    ]
    verbs = ["update"]
  }
  rule {
    api_groups = [""]
    resources = [
      "orders/finalizers"
    ]
    verbs = ["update"]
  }
  rule {
    api_groups = [""]
    resources = [
      "secrets"
    ]
    verbs = ["get", "list", "watch"]
  }
  rule {
    api_groups = [""]
    resources = [
      "events"
    ]
    verbs = ["create", "patch"]
  }
}

resource "kubernetes_cluster_role" "challenges_cluster_role" {
  metadata {
    name = "${var.name}-controller-challenges"
    labels = merge({
      "app.kubernetes.io/name" = var.name
    }, local.labels)
  }
  # Use to update challenge resource status
  rule {
    api_groups = ["acme.cert-manager.io"]
    resources = [
      "challenges",
      "challenges/status"
    ]
    verbs = ["update"]
  }
  # Used to watch challenge resources
  rule {
    api_groups = ["acme.cert-manager.io"]
    resources = [
      "challenges"
    ]
    verbs = ["get", "list", "watch"]
  }
  # Used to watch challenges, issuer and clusterissuer resources
  rule {
    api_groups = ["cert-manager.io"]
    resources = [
      "issuers",
      "clusterissuers"
    ]
    verbs = ["get", "list", "watch"]
  }
  # Need to be able to retrieve ACME account private key to complete challenges
  rule {
    api_groups = [""]
    resources = [
      "secrets"
    ]
    verbs = ["get", "list", "watch"]
  }
  # Used to create events
  rule {
    api_groups = [""]
    resources = [
      "events"
    ]
    verbs = ["create", "patch"]
  }
  # HTTP01 rules
  rule {
    api_groups = [""]
    resources = [
      "pods", "services"
    ]
    verbs = ["get", "list", "watch", "create", "delete"]
  }
  rule {
    api_groups = ["extensions", "networking.k8s.io"]
    resources = [
      "ingresses"
    ]
    verbs = ["get", "list", "watch", "create", "delete", "update"]
  }
  # We require these rules to support users with the OwnerReferencesPermissionEnforcement
  # admission controller enabled:
  # https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#ownerreferencespermissionenforcement
  rule {
    api_groups = ["acme.cert-manager.io"]
    resources = [
      "challenges/finalizers"
    ]
    verbs = ["update"]
  }
  # DNS01 rules (duplicated above)
  rule {
    api_groups = [""]
    resources = [
      "secrets"
    ]
    verbs = ["get", "list", "watch"]
  }
}

resource "kubernetes_cluster_role" "ingress_shim_cluster_role" {
  metadata {
    name = "${var.name}-controller-ingress-shim"
    labels = merge({
      "app.kubernetes.io/name" = var.name
    }, local.labels)
  }
  rule {
    api_groups = ["cert-manager.io"]
    resources = [
      "certificates",
      "certificaterequests"
    ]
    verbs = ["create", "update", "delete"]
  }
  rule {
    api_groups = ["cert-manager.io"]
    resources = [
      "certificates",
      "certificaterequests",
      "issuers",
      "clusterissuers"
    ]
    verbs = ["get", "list", "watch"]
  }
  rule {
    api_groups = ["extensions", "networking.k8s.io"]
    resources = [
      "ingresses"
    ]
    verbs = ["get", "list", "watch"]
  }
  # We require these rules to support users with the OwnerReferencesPermissionEnforcement
  # admission controller enabled:
  # https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#ownerreferencespermissionenforcement
  rule {
    api_groups = ["extensions", "networking.k8s.io"]
    resources = [
      "ingresses/finalizers"
    ]
    verbs = ["update"]
  }
  rule {
    api_groups = [""]
    resources = [
      "events"
    ]
    verbs = ["create", "patch"]
  }
}

resource "kubernetes_cluster_role" "view_cluster_role" {
  metadata {
    name = "${var.name}-view"
    labels = merge({
      "app.kubernetes.io/name"                       = var.name
      "rbac.authorization.k8s.io/aggregate-to-view"  = "true"
      "rbac.authorization.k8s.io/aggregate-to-edit"  = "true"
      "rbac.authorization.k8s.io/aggregate-to-admin" = "true"
    }, local.labels)
  }
  rule {
    api_groups = ["cert-manager.io"]
    resources = [
      "certificates",
      "certificaterequests",
      "issuers"
    ]
    verbs = ["get", "list", "watch"]
  }
}

resource "kubernetes_cluster_role" "edit_cluster_role" {
  metadata {
    name = "${var.name}-edit"
    labels = merge({
      "app.kubernetes.io/name"                       = var.name
      "rbac.authorization.k8s.io/aggregate-to-edit"  = "true"
      "rbac.authorization.k8s.io/aggregate-to-admin" = "true"
    }, local.labels)
  }
  rule {
    api_groups = ["cert-manager.io"]
    resources = [
      "certificates",
      "certificaterequests",
      "issuers"
    ]
    verbs = ["create", "delete", "deletecollection", "patch", "update"]
  }
}