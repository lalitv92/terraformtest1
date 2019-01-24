provider "kubernetes" {
config_path = "/home/opsmxuser/.kube/config"
}

resource "kubernetes_service" "echo" {
  metadata {
    name = "ngnix-service"
  }
  spec {
    selector {
      app = "firstapp"
    }
    port {
      port = 80
      target_port = 31277
    }
    #type = "LoadBalancer"
    type = "NodePort"	
} }
