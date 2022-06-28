locals {
  solver_http01 = var.letsencrypt.solvers.http01 == null ? [] : [{
    http01 = {
      ingress = {
        class = var.letsencrypt.solvers.http01.ingress_class
      }
    }
  }]

  solver_dns01 = var.letsencrypt.solvers.dns01 == null ? [] : [{
    dns01 = {
      route53 = {
        region = var.letsencrypt.solvers.dns01.route53.region
        role   = var.letsencrypt.solvers.dns01.route53.role
        secretAccessKeySecretRef = {
          name = ""
        }
      }
    }
  }]

  # As we add support for more solvers we can add them here. Cloudflare will probably be next
  enabled_solvers = concat(local.solver_http01, local.solver_dns01)
}