output "default_secret_name" {
  value       = "${kubernetes_service_account.tiller.default_secret_name}"
  description = "Name of the default secret the is created and managed by the service"
}

output "chart" {
  value       = ["${helm_release.charts.*.chart}"]
  description = "List of The names of the chart."
}

output "namespace" {
  value       = ["${helm_release.charts.*.namespace}"]
  description = "List of Namespaces is the kubernetes namespace of the release."
}

output "version" {
  value       = ["${helm_release.charts.*.version}"]
  description = "List of A SemVer-s 2 conformant version string of the chart."
}
