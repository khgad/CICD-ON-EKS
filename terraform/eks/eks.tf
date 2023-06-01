resource "aws_eks_cluster" "tf-eks" {
 name = "tf-cluster"
 role_arn = aws_iam_role.eks-iam-role.arn

 vpc_config {
  subnet_ids = var.private_subnets_id
  endpoint_private_access = true
  endpoint_public_access = false
  security_group_ids = [ aws_security_group.eks_sg.id ]
 }

 depends_on = [
  aws_iam_role.eks-iam-role,
 ]
}   