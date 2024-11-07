
resource "aws_vpc" "vpc_a" {
  provider   = aws.virginia
  cidr_block = var.vpc_a_cidr

  tags = {
    Name = "${local.app_name_dashed}-VPC-ADMIN"
  }
}

resource "aws_subnet" "subnet_a_public" {
  provider                = aws.virginia
  vpc_id                  = aws_vpc.vpc_a.id
  cidr_block              = var.subnet_a_cidr
  availability_zone       = var.availability_zone_a
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw_a" {
  provider = aws.virginia
  vpc_id   = aws_vpc.vpc_a.id
}

resource "aws_nat_gateway" "nat_a" {
  provider      = aws.virginia
  subnet_id     = aws_subnet.subnet_a_public.id
  allocation_id = aws_eip.eip_nat_a.id

  depends_on = [aws_internet_gateway.igw_a]
}

resource "aws_eip" "eip_nat_a" {
  provider = aws.virginia
}

resource "aws_vpc" "vpc_b" {
  provider   = aws.oregon
  cidr_block = var.vpc_b_cidr

  tags = {
    Name = "${local.app_name_dashed}-VPC-DEV"
  }
}

resource "aws_subnet" "subnet_b_private" {
  provider          = aws.oregon
  vpc_id            = aws_vpc.vpc_b.id
  cidr_block        = var.subnet_b_cidr
  availability_zone = var.availability_zone_b
}


resource "aws_vpc" "vpc_c" {
  provider   = aws.ohio
  cidr_block = var.vpc_c_cidr

  tags = {
    Name = "${local.app_name_dashed}-VPC-PROD"
  }
}

resource "aws_subnet" "subnet_c_private" {
  provider          = aws.ohio
  vpc_id            = aws_vpc.vpc_c.id
  cidr_block        = var.subnet_c_cidr
  availability_zone = var.availability_zone_c
}
