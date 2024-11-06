resource "digitalocean_kubernetes_cluster" "ridwanfirst" {
  name    = "ridwanfirst"
  region  = "lon1"
  version = "1.31.1-do.3"

  node_pool {
    name       = "worker-nodes"
    size       = "s-2vcpu-2gb"
    node_count = 1
  }
}

resource "helm_release" "argocd01" {
  name             = "argocd01"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "7.6.12"
  namespace        = "argocd"
  create_namespace = true

  set {
    name  = "values.server.service.type"
    value = "NodePort"
  }
}


resource "helm_release" "kube-prometheus" {
  name             = "kube-prometheus-stackr"
  namespace        = "monitoring"
  version          = "65.7.0"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  create_namespace = true
}
