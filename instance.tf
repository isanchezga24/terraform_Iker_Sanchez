data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

resource "aws_key_pair" "niregiltza" {
  key_name   = var.ssh_key_name
  public_key = file(".giltza.pub")
}

resource "aws_instance" "wordpress_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = aws_key_pair.niregiltza.key_name
  user_data              = file("userdata.sh")

  tags = { Name = "WordPress-Server" }
}