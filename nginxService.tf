provider "kubernetes" {
config_path = "/home/opsmxuser/.kube/config"
}

resource "kubernetes_service" "echo" {
  metadata {
    name = "ngnix-service"
  }
  spec {
    selector {
      App = "firstapp"
    }
    port {
      port        = 31277
      target_port = 80
    }
    #type = "LoadBalancer"
    type = "NodePort"	
} }
