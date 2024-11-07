resource "aws_vpc" "myvpc" {
  cidr_block = var.vpc_cidr
  tags = merge(
    { Name = "${var.customer}-${var.environment}-VPC" },
    local.tags
  )
}


resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true
  tags = merge(
    { Name = "${var.customer}-${var.environment}-SB-PBL" },
    local.tags
  )
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.public_subnet_b_cidr
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = true
  tags = merge(
    { Name = "${var.customer}-${var.environment}-SB-B-PBL" },
    local.tags
  )
}


resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.private_subnet_cidr
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = false
  tags = merge(
    { Name = "${var.customer}-${var.environment}-SB-PVT" },
    local.tags
  )
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
  tags = merge(
    { Name = "${var.customer}-${var.environment}-IGW" },
    local.tags
  )
}



resource "aws_eip" "nat_eip" {
  tags = merge(
    { Name = "${var.customer}-${var.environment}-EIP" },
    local.tags
  )
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id
  tags = merge(
    { Name = "${var.customer}-${var.environment}-NATGW" },
    local.tags
  )
}



resource "aws_network_acl" "acl" {
  vpc_id = aws_vpc.myvpc.id
  tags = merge(
    { Name = "${var.customer}-${var.environment}-ACL" },
    local.tags
  )
}


resource "aws_network_acl_rule" "inbound_http" {
  network_acl_id = aws_network_acl.acl.id
  rule_number    = 100
  egress         = false
  protocol       = var.protocol
  rule_action    = "allow"
  cidr_block     = var.cidr_block
  from_port      = var.from_port
  to_port        = var.to_port
}

resource "aws_network_acl_rule" "outbound_all" {
  network_acl_id = aws_network_acl.acl.id
  rule_number    = 100
  egress         = true
  protocol       = var.protocol
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = var.from_port
  to_port        = var.to_port
}


resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = var.cidr_block
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge(
    { Name = "${var.customer}-${var.environment}-RT-PBL" },
    local.tags
  )
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_subnet_b_association" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_rt.id
}


resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block     = var.cidr_block
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
  tags = merge(
    { Name = "${var.customer}-${var.environment}-RT-PVT" },
    local.tags
  )
}

resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}