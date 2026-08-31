resource "aws_key_pair" "ec2_key_pair" {
  key_name = "ec2_key_pair"
  public_key = file("ec2_key_pair.pub")
}


resource "aws_instance" "server" {
  ami = "ami-01a00762f46d584a1"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.public-sub-1a.id
  vpc_security_group_ids = [ aws_security_group.ec2-sg.id ]
  key_name = aws_key_pair.ec2_key_pair.key_name
  user_data = file("script.sh")

  tags = {
    Name = "3-tier-stack-server"
  }
}

resource "aws_lb_target_group_attachment" "app_tg_attach" {
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id = aws_instance.server.id
  port = 80
}