terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name = "nginx"
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "nginx-created-by-terraform"

  ports {
    internal = 80
    external = 8000
  }
}
