resource "null_resource" "pre_flight" {
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${var.cluster_name}"
  }

  provisioner "local-exec" {
    command = "helm init --upgrade"
  }
}

provider "kubernetes" {
  host                   = "${var.host}"
  cluster_ca_certificate = "${var.ca_certificate}"
}

resource "kubernetes_service_account" "tiller" {
  metadata {
    name      = "tiller"
    namespace = "kube-system"
  }

  depends_on = ["null_resource.pre_flight"]
}

resource "kubernetes_cluster_role_binding" "cluster_admin" {
  metadata {
    name = "tiller"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    api_group = ""
    name      = "tiller"
    kind      = "ServiceAccount"
    namespace = "kube-system"
  }

  depends_on = ["kubernetes_service_account.tiller"]
}

resource "null_resource" "Bug" {
  provisioner "local-exec" {
    command = "./tf-module-aws-eks/helm_installs/setting_helm.sh"
  }

  depends_on = ["kubernetes_cluster_role_binding.cluster_admin"]
}

resource "helm_release" "charts" {
  count      = "${length(var.charts)}"
  name       = "${lookup( var.charts[count.index], "name" )}"
  chart      = "${lookup( var.charts[count.index], "chart")}"
  timeout    = "600"
  depends_on = ["null_resource.Bug"]
}
