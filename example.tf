provider "aws" {
  version = "~> 1.27"
}

resource "aws_instance" "example" {
  ami           = "ami-44bf9f21"
  instance_type = "t2.micro"
  iam_instance_profile="${aws_iam_instance_profile.ec2-role.name}"
  key_name = "gabriel"
 
  tags {
    Name = "gabriel-terraform-iam"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }
}

resource "aws_eip" "ip" {
  instance = "${aws_instance.example.id}"
}

output "ip" {
  value = "${aws_eip.ip.public_ip}"
}