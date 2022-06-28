locals {
  solver_http01 = var.letsencrypt.solvers.http01 == null ? null : {
    ingress = {
      class = var.letsencrypt.solvers.http01.ingress_class
    }
  }

  solver_dns01 = var.letsencrypt.solvers.dns01 == null ? null : {
    route53 = local.solver_dns01_route53
  }

  solver_dns01_route53 = var.letsencrypt.solvers.dns01.route53 == null ? null : {
    region      = var.letsencrypt.solvers.dns01.route53.region
    role        = var.letsencrypt.solvers.dns01.route53.role
    accessKeyID = var.letsencrypt.solvers.dns01.route53.access_key_id
    secretAccessKeySecretRef = var.letsencrypt.solvers.dns01.route53.access_key_secret == null ? null : {
      name = var.letsencrypt.solvers.dns01.route53.access_key_secret.name
      key  = var.letsencrypt.solvers.dns01.route53.access_key_secret.key
    }
  }
}