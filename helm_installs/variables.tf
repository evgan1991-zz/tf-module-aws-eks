variable "cluster_name" {
  type        = "string"
  description = "Cluster name"
}

variable "host" {
  type        = "string"
  default     = ""
  description = "host"
}

variable "ca_certificate" {
  type        = "string"
  default     = ""
  description = "ca_certificate"
}

variable "charts" {
  type        = "list"
  description = "Installing soft"

  default = [
    {
      name  = "prometheus"
      chart = "stable/prometheus"
    },
    {
      name  = "grafana"
      chart = "stable/grafana"
    },
  ]
}
