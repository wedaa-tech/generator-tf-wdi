terraform {
 required_providers {
  aws = {
   source = "hashicorp/aws"
  }
 }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "aws" {
  region     = var.region
}
