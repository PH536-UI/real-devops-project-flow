provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    ec2  = "http://localhost:4568"
    ecs  = "http://localhost:4568"
    sts  = "http://localhost:4568"
  }
}

module "vpc" {
  source = "./modules/vpc"
}

module "ecs_fargate" {
  source    = "./modules/ecs_fargate"
  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.private_subnet_id
}
