# module "vpc" {
#   source = "../../modules/vpc"

#   region               = "us-east-1"
#   name                 = "dev"
#   cidr_block           = "10.0.0.0/16"
#   public_subnet_count  = 2
#   private_subnet_count = 2
#   public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
#   private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
#   availability_zones   = ["us-east-1a", "us-east-1b"]
# }

# module "ecs" {
#   source       = "../../modules/ecs"
#   cluster_name = "dev-cluster"
# }

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.name
  name  = "nginx-container"
  ports {
    internal = 80
    external = 8080
  }
}

resource "aws_ecs_cluster" "main" {
  name = var.cluster_name
  tags = {
    Name = var.cluster_name
  }
}