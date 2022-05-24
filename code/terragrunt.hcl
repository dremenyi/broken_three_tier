generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents = <<EOF
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.15.1"
    }
}
    
    backend "s3" {
    bucket = "terraform-three-tier-demo-dakota"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region = "us-east-1"
   }
  }

EOF
}

