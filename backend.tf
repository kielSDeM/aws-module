terraform {
  backend "remote" {
    organization = "aws_module"

    workspaces {
      name = "terraform-aws-ec2-instance"
    }
  }
}