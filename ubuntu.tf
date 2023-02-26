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

  owners = ["099720109477"]
}


resource "aws_instance" "lampsetup" {
  count                       = var.az_count
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.websubnets[count.index % var.az_count].id
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.websg.id]
  associate_public_ip_address = true


  root_block_device {
    volume_size           = var.root_volume_size
    delete_on_termination = true
    # encrypted             = true
    volume_type           = "gp2"

    tags = {
      Name = "rootVolume"
    }
  }


  user_data = file("installAnsibleUbuntu.sh")

  provisioner "file" {
    source      = "install_lamp.yml"
    destination = "/home/ubuntu/install_lamp.yml"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("./dawan.pem")
      host        = self.public_ip
    }
  }

  provisioner "file" {
    source      = "index.html"
    destination = "/home/ubuntu/index.html"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("./dawan.pem")
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sleep 120; ansible-playbook install_lamp.yml"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("./dawan.pem")
      host        = self.public_ip
    }
  }

  

  tags = {
    Name = "Lamp"
  }
}
 