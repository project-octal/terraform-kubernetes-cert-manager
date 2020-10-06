variable "letsencrypt" {
  type = object({
    name: string,
    server: string,
    email: string,
    ingress_class: string,
    labels: map(string)
  })
  default = null
}
