

# EC2 Instances --------------------------------------------------


resource "aws_instance" "ec2_a_public" {
  provider      = aws.virginia
  ami           = var.ami_virginia
  instance_type = var.instance_type
  subnet_id     = aws_subnet.subnet_a_public.id
  key_name      = aws_key_pair.ec2_key_pair.key_name

  security_groups = [aws_security_group.sg_virginia.id]

  depends_on = [
    aws_security_group.sg_virginia,
    aws_nat_gateway.nat_a,
    aws_internet_gateway.igw_a
  ]

  tags = {
    Name = "${local.app_name_dashed}-EC2-A"
  }
}


resource "aws_instance" "ec2_b_private" {
  provider      = aws.oregon
  ami           = var.ami_oregon
  instance_type = var.instance_type
  subnet_id     = aws_subnet.subnet_b_private.id
  key_name      = aws_key_pair.ec2_key_pair_oregon.key_name

  security_groups = [aws_security_group.sg_b_oregon.id]
  depends_on      = [aws_vpc.vpc_b]

  tags = {
    Name = "${local.app_name_dashed}-EC2-B"
  }
}


resource "aws_instance" "ec2_c_private" {
  provider      = aws.ohio
  ami           = var.ami_ohio
  instance_type = var.instance_type
  subnet_id     = aws_subnet.subnet_c_private.id
  key_name      = aws_key_pair.ec2_key_pair_ohio.key_name

  security_groups = [aws_security_group.sg_c_ohio.id]
  depends_on      = [aws_vpc.vpc_c]

  tags = {
    Name = "${local.app_name_dashed}-EC2-C"
  }
}