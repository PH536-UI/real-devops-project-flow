provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style           = true

  endpoints {
    ecs = "http://localhost:4568"
    ec2 = "http://localhost:4568"
    s3  = "http://localhost:4568"
    kms = "http://localhost:4568"
  }
}
