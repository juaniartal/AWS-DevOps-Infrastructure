resource "aws_security_group" "sg_virginia" {
  provider = aws.virginia
  vpc_id   = aws_vpc.vpc_a.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0", "10.1.0.0/16", "10.2.0.0/16"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.1.0.0/16", "10.2.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  depends_on = [aws_vpc.vpc_a]
  tags = merge(
    { Name = "${var.customer}-${var.environment}-SG-PUBLIC" },
    local.tags
  )
}


resource "aws_security_group" "sg_b_oregon" {
  provider = aws.oregon
  vpc_id   = aws_vpc.vpc_b.id

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.0.0.0/16", "0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0", "10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  depends_on = [aws_vpc.vpc_b]
  tags = merge(
    { Name = "${var.customer}-${var.environment}-SG-oregon" },
    local.tags
  )
}

resource "aws_security_group" "sg_c_ohio" {
  provider = aws.ohio
  vpc_id   = aws_vpc.vpc_c.id


  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.0.0.0/16"]
  }


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  depends_on = [aws_vpc.vpc_b]
  tags = merge(
    { Name = "${var.customer}-${var.environment}-SG-Ohio" },
    local.tags
  )
}
