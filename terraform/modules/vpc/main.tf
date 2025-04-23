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

provider "aws" {
  region = var.region
}

provider "docker" {}

resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.name}-vpc"
  }
}

resource "aws_subnet" "public" {
  count                   = var.public_subnet_count
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  map_public_ip_on_launch = true
  availability_zone       = element(var.availability_zones, count.index)
  tags = {
    Name = "${var.name}-public-${count.index}"
  }
}

resource "aws_subnet" "private" {
  count             = var.private_subnet_count
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)
  tags = {
    Name = "${var.name}-private-${count.index}"
  }
}

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