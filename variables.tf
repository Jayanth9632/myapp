variable "aws_region" {
  default = "ap-south-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami_id" {
  default = "ami-0f58c7d8c2b2e6f8e"
}

variable "key_name" {
  default = "jenkins-key"
}

variable "public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}
