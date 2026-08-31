resource "aws_security_group" "alb-sg" {
  name = "3-tier-stack-alb-sg"
  vpc_id = aws_vpc.vpc-main.id
  description = "Allow inbound traffic from the internet"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "Allow HTTP"
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "Allow all outbound traffic"
  }
}


resource "aws_security_group" "ec2-sg" {
  name = "3-tier-stack-ec2-sg"
  description = "Allow HTTP and ALB and SSH from internet"
  vpc_id = aws_vpc.vpc-main.id

  ingress{
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "Allow HTTP"
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "Allow SSH"
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "Allow all outbound traffic"
  }
} 