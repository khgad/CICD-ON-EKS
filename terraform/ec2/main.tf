resource "aws_instance" "public_ec2" {
  ami           = var.ami
  instance_type = "t2.micro"
  subnet_id     = var.public_subnets_id[count.index]
  key_name      = var.key_name

  vpc_security_group_ids = [
    aws_security_group.allow_ssh_http.id
  ]

  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> inventory"
    working_dir = "../ansible"
  }

  tags = {
    "Name" = "Bastion Host"
  }

  count = length(var.public_subnets_id)

  # depends_on = var.dependances
}

resource "aws_instance" "private_ec2" {
  ami           = var.ami
  instance_type = "t2.micro"
  subnet_id     = var.private_subnets_id[count.index]
  key_name      = var.key_name

  vpc_security_group_ids = [
    aws_security_group.allow_ssh_http.id
  ]

  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> inventory"
    working_dir = "../ansible"
  }

  tags = {
    "Name" = "Bastion Host"
  }

  count = length(var.private_subnets_id)

  # depends_on = var.dependances
}