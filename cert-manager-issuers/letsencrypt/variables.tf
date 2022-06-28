variable "namespace" {
  type = string
}
variable "letsencrypt" {
  type = object({
    name              = string,
    server            = string,
    email             = string,
    secret_base64_key = string,
    default_issuer    = bool,
    solvers = object({
      http01 = object({
        ingress_class = string
      }),
      dns01 = object({
        route53 = object({
          region = string,
          role   = string
        })
      })
    })
  })
  default = null
}