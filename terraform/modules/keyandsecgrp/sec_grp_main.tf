variable "ports" {
  type = list(number)

  default = [22, 80, 443, 8443, 8080, 7010]
}


resource "aws_security_group" "sec_grp" {
  name = "python_sec_grp"

  dynamic "ingress" {
    for_each = var.ports

    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "python sec group"
    }
  }

  ingress {
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "python sec group"
  }

  ingress {
    from_port   = 3000
    to_port     = 11000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "python sec group"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "python sec group"
  }

  tags = {
    Name = "python_sec_group"
  }
}
