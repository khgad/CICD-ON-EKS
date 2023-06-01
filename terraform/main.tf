module "network" {
  source = "./network"

  cidr                 = "10.0.0.0/16"
  public_subnets_cidr  = ["10.0.1.0/24"]
  private_subnets_cidr = ["10.0.2.0/24", "10.0.4.0/24"]
  AZs                  = ["us-east-1a", "us-east-1b"]
}

module "security" {
  source = "./security"
}

module "instances" {
  source = "./ec2"

  vpc_id            = module.network.vpc_id
  public_subnets_id = module.network.public_subnets_id
  # private_subnets_id     = module.network.private_subnets_id
  # allow_ssh_http_sg_id = module.security.allow_ssh_http_sg_id
  key_name    = module.security.key_name
  dependances = []
}

module "eks" {
  source = "./eks"

  vpc_id               = module.network.vpc_id
  private_subnets_id = module.network.private_subnets_id
  bastion_sg_id = module.instances.allow_ssh_http_sg_id
}

resource "null_resource" "run_ansible" {
  provisioner "local-exec" {
    command = "ansible-playbook playbook.yml --extra-vars 'cluster_name=${module.eks.eks_name} cluster_region=us-east-1'"
    working_dir = "../ansible"
  }
  depends_on = [ module.network, module.security, module.instances, module.eks ]
}