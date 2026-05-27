# provider.tf
terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  # Apenas para ambiente local (Floci)
  dynamic "endpoints" {
    for_each = var.aws_endpoint != null ? [1] : []
    content {
      s3       = var.aws_endpoint
      dynamodb = var.aws_endpoint
      lambda   = var.aws_endpoint
      sqs      = var.aws_endpoint
      sns      = var.aws_endpoint
      ec2      = var.aws_endpoint
      rds      = var.aws_endpoint
      iam      = var.aws_endpoint
      sts      = var.aws_endpoint
      kms      = var.aws_endpoint
      secretsmanager = var.aws_endpoint
      cloudwatch     = var.aws_endpoint
      logs           = var.aws_endpoint
      # Adicione outros serviços conforme necessidade
    }
  }

  # Credenciais dummy para Floci; em AWS real usa IAM role / AWS CLI config
  access_key = var.environment == "local" ? "test" : null
  secret_key = var.environment == "local" ? "test" : null

  # S3 path-style necessário para emuladores locais
  s3_use_path_style = var.environment == "local" ? true : false

  default_tags {
    tags = local.common_tags
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}
