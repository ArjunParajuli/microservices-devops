terraform {
 required_providers {
   aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
 } 


    backend "s3" {
        bucket = "demo-terraform-eks-state-s3-bucket"
        key            = "terraform.tfstate"
        region         = "us-west-2"
        dynamodb_table = "terraform-eks-state-locks"
        encrypt        = true
    }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./vpc-module"

  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidrs  = var.public_subnet_cidrs
  cluster_name         = var.cluster_name
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "my-eks-cluster"
}

