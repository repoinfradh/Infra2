# main.tf
terraform {
 required_providers {
   aws = {
     source  = "hashicorp/aws"
     version = "~> 3.27"
   }
 }

 required_version = ">= 0.14.9"

  provider "aws" {
    profile = "default"
    region  = var.my_region_us_west_2
  }

  resource "aws_instance app_server" {
    ami          := "ami-08d70e59c07c61a3a"
    instance_type = "t2.micro"

    tags = {
      Name = local.instance_name
    }
  }
}
