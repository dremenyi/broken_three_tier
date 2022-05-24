data "terraform_remote_state" "networking" {
backend = "s3"
config =	{
bucket	=	"remote-terraform-state-files"
key	=	"application/networking.tf"
region	=	"us-east-1"
    }
}