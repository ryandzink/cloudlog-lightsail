terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

resource "aws_lightsail_key_pair" "cloudlog" {
  name = "${local.callsign}_key_pair"
}

resource "local_file" "private_key" {
  content  = aws_lightsail_key_pair.cloudlog.private_key
  filename = "lightsail.pem"
}

resource "random_pet" "host_suffix" {
  keepers = {
    instance = filebase64("${path.module}/user_data.txt")
  }
}

resource "aws_lightsail_instance" "cloudlog" {
  name              = "cloudlog-${local.callsign}-${random_pet.host_suffix.id}"
  availability_zone = "${local.region}a"
  blueprint_id      = "lamp_7"
  bundle_id         = "nano_2_0"
  key_pair_name     = aws_lightsail_key_pair.cloudlog.name
  user_data         = file("${path.module}/user_data.txt")
}

resource "aws_lightsail_instance_public_ports" "lightsail" {
  instance_name = aws_lightsail_instance.cloudlog.name

  dynamic "port_info" {
    for_each = local.permit_ssh == true ? [1] : []
    content {
      protocol  = "tcp"
      from_port = 22
      to_port   = 22
      cidrs     = ["${data.external.my_public_ip.result.ip}/32"]
    }
  }

  port_info {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80
    cidrs     = ["0.0.0.0/0"]
  }
}

resource "aws_lightsail_static_ip" "cloudlog" {
  name = "cloudlog-${local.callsign}"
}

resource "aws_lightsail_static_ip_attachment" "public_ip" {
  static_ip_name = aws_lightsail_static_ip.cloudlog.id
  instance_name  = aws_lightsail_instance.cloudlog.id
}