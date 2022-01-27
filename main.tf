module "vpc_module" {
  source       = "../AWS_module/vpc_module"
  vpc_cidr     = var.vpc_cidr
  public_cidr  = var.public_cidr
  private_cidr = var.private_cidr
  region       = var.region
}
module "ec2_module" {
  source       = "../AWS_module/ec2_module"
  ami          = var.ami
  t2_instances = var.t2_instances
  m4_instances = var.m4_instances
  ec2_count    = var.ec2_count_i1
  ec2_count_2  = var.ec2_count_i2
  region       = var.region
  pub_sub      = module.vpc_module.pub_sub_id
  priv_sub     = module.vpc_module.priv_sub_id
  sec_group    = module.vpc_module.security_group_output
}

module "eks_module" {
  source       = "../AWS_module/eks_module"
  ami          = var.ami
  t2_instances = var.t2_instances
  m4_instances = var.m4_instances
  ec2_count    = var.ec2_count_i1
  ec2_count_2  = var.ec2_count_i2
  region       = var.region
  pub_sub      = module.vpc_module.pub_sub_id
  priv_sub     = module.vpc_module.priv_sub_id
  sec_group    = module.vpc_module.security_group_output

}