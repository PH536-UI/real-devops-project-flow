module "vpc" { source = "../../modules/vpc" }
module "kms" { source = "../../modules/kms" }
module "s3" { 
  source      = "../../modules/s3"
  kms_key_arn = module.kms.key_arn
}
module "ecs" {
  source    = "../../modules/ecs_fargate"
  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.private_subnet_id
}
