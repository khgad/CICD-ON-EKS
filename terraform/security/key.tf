resource "tls_private_key" "tls_key" {
  algorithm = "RSA"
  rsa_bits  = 4096

  # provisioner "local-exec" {
  #   command = "echo ${self.private_key_pem} > ../ansible/key.pem"
  #   # working_dir = "../ansible"
  # }
}

resource "local_file" "private_key_file" {
  content  = tls_private_key.tls_key.private_key_pem
  filename = "../ansible/key.pem"
  file_permission = "0600"
}

resource "aws_key_pair" "tf_key" {
  key_name   = "tf-key"
  public_key = tls_private_key.tls_key.public_key_openssh
}