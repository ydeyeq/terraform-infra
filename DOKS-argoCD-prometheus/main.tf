resource "digitalocean_kubernetes_cluster" "ridwanfirst" {
  name    = "ridwanfirst"
  region  = "lon1"
  version = "1.31.1-do.3"

  node_pool {
    name       = "worker-nodes"
    size       = "s-2vcpu-2gb"
    node_count = 3
  }
}

resource "digitalocean_spaces_bucket" "cloud_assets" {
  name   = "junkyard"
  region = "lon1"
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
  name             = "prometheus"
  namespace        = "monitoring"
  version          = "65.7.0"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  create_namespace = true

  values = [
    "${file("prometheusValues.yaml")}"
  ]
}

resource "helm_release" "loki-distributed" {
  name       = "loki"
  chart      = "loki-distributed"
  version    = "0.79.4"
  namespace  = "monitoring"
  repository = "https://grafana.github.io/helm-charts"

  values = [
    "${file("lokiValues.yaml")}"
  ]
}


resource "helm_release" "promtail" {
  name       = "promtail"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "promtail"
  version    = "6.16.6"
  namespace  = "monitoring"

  set {
    name  = "configmap.enabled"
    value = "true"
  }

  values = [
    "${file("promtailValues.yaml")}"
  ]
}
