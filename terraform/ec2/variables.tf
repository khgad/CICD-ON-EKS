variable "ami" {
  type = string
  default = "ami-053b0d53c279acc90"
  description = "ami for ubuntu 22.04"
}

variable "vpc_id" {
  type = string
}

variable "public_subnets_id" {
  default = []
}

variable "private_subnets_id" {
default = []
}

variable "key_name" {
  type = string
}

variable "dependances" {
  default = []
}