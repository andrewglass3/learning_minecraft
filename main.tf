provider "aws" {
  region = "eu-west-2"
  
}

resource "aws_vpc" "minecraft" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = var.vpcname
 }
}
resource "aws_internet_gateway" "minegate" {
    vpc_id = aws_vpc.minecraft.id

    tags = {
      "Name" = var.gatewayname
    }
  
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "minecraft_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "Minecraft_Server"
  }
}
