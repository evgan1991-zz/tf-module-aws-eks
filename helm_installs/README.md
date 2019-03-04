# Helm_installs
The module automatically installs a list of programs on the EKS-cluster.

## Usage example

```hcl
module "helm_installs" {
  source = "helm_installs/"
  cluster_name = "my_cluster_id"
  host = "https://cluster_endpoint"
  ca_certificate = "my_cluster_certificate_authority_data"
  charts = [
  {
    name  = "prometheus"
    chart = "stable/prometheus"
  },
  {
    name  = "grafana"
    chart = "stable/grafana"
  },
  {
    name  = "nginx-ingress"
    chart = "stable/nginx-ingress"
  }]
}

```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cluster_name | The NAME of the cluster for which the software will be installed | string | n/a | yes |
| host | The ENDPOINT of the cluster for which the software will be installed | string | "" | no |
| ca_certificate | The certificate authority of the cluster | string | "" | no |
| charts | list of charts. Default values are taken in [this repository](https://github.com/helm/charts) | list | [{name  = "prometheus" chart = "stable/prometheus" }, { name  = "grafana" chart = "stable/grafana"}] | no |

## Outputs

| Name | Description |
|------|-------------|
|default_secret_name | name of the default secret the is created and managed by the service |
|chart | List of names-chart |
|namespace | List of namespaces kubernetes |
|version | List of chart versions |
