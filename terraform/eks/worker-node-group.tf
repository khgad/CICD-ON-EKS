 resource "aws_eks_node_group" "worker-node-group" {
  cluster_name  = aws_eks_cluster.tf-eks.name
  node_group_name = "tf-workernodes"
  node_role_arn  = aws_iam_role.workernodes-iam.arn
  subnet_ids   = var.private_subnets_id
  instance_types = ["t2.small"]
 
  scaling_config {
   desired_size = 2
   max_size   = 2
   min_size   = 2
  }
 
  depends_on = [
   aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
   aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
   aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
 }