# ########################################Transit Gateways ########################################

resource "aws_ec2_transit_gateway" "tg_virginia" {
  provider                        = aws.virginia
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  tags = {
    Name = "${local.app_name_dashed}-TG-VIRGINIA"
  }
}


resource "aws_ec2_transit_gateway" "tg_oregon" {
  provider                        = aws.oregon
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"

  tags = {
    Name = "${local.app_name_dashed}-TG-OREGON"
  }
}

resource "aws_ec2_transit_gateway" "tg_ohio" {
  provider                        = aws.ohio
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"

  tags = {
    Name = "${local.app_name_dashed}-TG-OHIO"
  }
}

######################################## ATTACHMENT ########################################
resource "aws_ec2_transit_gateway_vpc_attachment" "attachment_virginia" {
  provider           = aws.virginia
  subnet_ids         = [aws_subnet.subnet_a_public.id] # Public subnet for attachment
  transit_gateway_id = aws_ec2_transit_gateway.tg_virginia.id
  vpc_id             = aws_vpc.vpc_a.id

  tags = {
    Name = "${local.app_name_dashed}-TG-ATTACHMENT-VIRGINIA"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "attachment_oregon_dev" {
  provider           = aws.oregon
  subnet_ids         = [aws_subnet.subnet_b_private.id]
  transit_gateway_id = aws_ec2_transit_gateway.tg_oregon.id
  vpc_id             = aws_vpc.vpc_b.id

  tags = {
    Name = "${local.app_name_dashed}-TG-ATTACHMENT-OREGON-DEV"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "attachment_ohio_prod" {
  provider           = aws.ohio
  subnet_ids         = [aws_subnet.subnet_c_private.id]
  transit_gateway_id = aws_ec2_transit_gateway.tg_ohio.id
  vpc_id             = aws_vpc.vpc_c.id
  tags = {
    Name = "${local.app_name_dashed}-TG-ATTACHMENT-OHIO-PROD"
  }
}


########################  Route Tables ########################################


resource "aws_route_table" "route_table_virginia" {
  provider   = aws.virginia
  vpc_id     = aws_vpc.vpc_a.id
  depends_on = [aws_internet_gateway.igw_a]

  // internet
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_a.id # sb
  }

  route {
    cidr_block         = "10.1.0.0/16"
    transit_gateway_id = aws_ec2_transit_gateway.tg_virginia.id
  }

  route {
    cidr_block         = "10.2.0.0/16"
    transit_gateway_id = aws_ec2_transit_gateway.tg_virginia.id
  }

  tags = {
    Name = "${local.app_name_dashed}-RT-VIRGINIA"
  }
}




resource "aws_route_table" "route_table_oregon_dev" {
  provider = aws.oregon
  vpc_id   = aws_vpc.vpc_b.id

  route {
    cidr_block         = "0.0.0.0/0" # VPC  vir
    transit_gateway_id = aws_ec2_transit_gateway.tg_oregon.id
  }

  tags = {
    Name = "${local.app_name_dashed}-RT-OREGON-DEV"
  }
}



resource "aws_route_table" "route_table_ohio_prod" {
  provider = aws.ohio
  vpc_id   = aws_vpc.vpc_c.id

  route {
    cidr_block         = "0.0.0.0/0"
    transit_gateway_id = aws_ec2_transit_gateway.tg_ohio.id
  }

  tags = {
    Name = "${local.app_name_dashed}-RT-OHIO-PROD"
  }
}



########################  Asociaciones ####################### 

resource "aws_route_table_association" "rt_assoc_virginia" {
  provider       = aws.virginia
  subnet_id      = aws_subnet.subnet_a_public.id
  route_table_id = aws_route_table.route_table_virginia.id
}

resource "aws_route_table_association" "rt_assoc_oregon_dev" {
  provider       = aws.oregon
  subnet_id      = aws_subnet.subnet_b_private.id
  route_table_id = aws_route_table.route_table_oregon_dev.id
}

resource "aws_route_table_association" "rt_assoc_ohio_prod" {
  provider       = aws.ohio
  subnet_id      = aws_subnet.subnet_c_private.id
  route_table_id = aws_route_table.route_table_ohio_prod.id
}

########################  ROUTE TABLE ####################### 


resource "aws_ec2_transit_gateway_route_table" "tg_route_table_virginia" {
  provider           = aws.virginia
  transit_gateway_id = aws_ec2_transit_gateway.tg_virginia.id

  tags = {
    Name = "${local.app_name_dashed}-TG-ROUTE-TABLE-VIRGINIA"
  }
}


resource "aws_ec2_transit_gateway_route_table" "tg_route_table_oregon" {
  provider           = aws.oregon
  transit_gateway_id = aws_ec2_transit_gateway.tg_oregon.id

  tags = {
    Name = "${local.app_name_dashed}-TG-ROUTE-TABLE-OREGON"
  }
}

resource "aws_ec2_transit_gateway_route_table" "tg_route_table_ohio" {
  provider           = aws.ohio
  transit_gateway_id = aws_ec2_transit_gateway.tg_ohio.id

  tags = {
    Name = "${local.app_name_dashed}-TG-ROUTE-TABLE-OHIO"
  }
}


########################  PROPAGACIONES ####################### 
resource "aws_ec2_transit_gateway_route_table_propagation" "propagate_virginia_vpc" {
  provider                       = aws.virginia
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tg_route_table_virginia.id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.attachment_virginia.id
}


resource "aws_ec2_transit_gateway_route_table_propagation" "propagate_oregon_dev_vpc" {
  provider                       = aws.oregon
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tg_route_table_oregon.id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.attachment_oregon_dev.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "propagate_ohio_prod_vpc" {
  provider                       = aws.ohio
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tg_route_table_ohio.id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.attachment_ohio_prod.id
}

########################  Asociaciones del Transit Gateway Route Table ####################### 


resource "aws_ec2_transit_gateway_route_table_association" "associate_virginia_vpc" {
  provider                       = aws.virginia
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tg_route_table_virginia.id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.attachment_virginia.id
  replace_existing_association   = true

}

resource "aws_ec2_transit_gateway_route_table_association" "associate_oregon_dev_vpc" {
  provider                       = aws.oregon
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tg_route_table_oregon.id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.attachment_oregon_dev.id
  replace_existing_association   = true
}

resource "aws_ec2_transit_gateway_route_table_association" "associate_ohio_prod_vpc" {
  provider                       = aws.ohio
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tg_route_table_ohio.id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.attachment_ohio_prod.id
}

####################### Asociación del Peering entre los Transit Gateways ########################################


resource "aws_ec2_transit_gateway_route_table_association" "associate_peering_virginia" {
  provider                       = aws.virginia
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tg_route_table_virginia.id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.tg_peering.id
  replace_existing_association   = true
}

resource "aws_ec2_transit_gateway_route_table_association" "associate_peering_oregon" {
  provider                       = aws.oregon
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tg_route_table_oregon.id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment_accepter.tg_peering_accepter.id
  replace_existing_association   = true
}
resource "aws_ec2_transit_gateway_route_table_association" "associate_peering_virginia_ohio" {
  provider                       = aws.virginia
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tg_route_table_virginia.id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.tg_peering_virginia_to_ohio.id
  replace_existing_association   = true
}

resource "aws_ec2_transit_gateway_route_table_association" "associate_peering_ohio_virginia" {
  provider                       = aws.ohio
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tg_route_table_ohio.id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment_accepter.tg_peering_accepter_ohio.id
  replace_existing_association   = true
}

####################### ROUTES ########################################

resource "aws_ec2_transit_gateway_route" "tg_route_to_oregon_from_virginia" {
  provider                       = aws.virginia
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tg_route_table_virginia.id
  destination_cidr_block         = "10.1.0.0/16" #vpc b
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.tg_peering.id
  depends_on                     = [aws_ec2_transit_gateway_peering_attachment_accepter.tg_peering_accepter]
}

resource "aws_ec2_transit_gateway_route" "tg_route_to_virginia_from_oregon" {
  provider                       = aws.oregon
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tg_route_table_oregon.id
  destination_cidr_block         = "10.0.0.0/16" #vpc A
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.tg_peering.id
  depends_on                     = [aws_ec2_transit_gateway_peering_attachment_accepter.tg_peering_accepter]
}

resource "aws_ec2_transit_gateway_route" "tg_route_to_ohio_from_virginia" {
  provider                       = aws.virginia
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tg_route_table_virginia.id
  destination_cidr_block         = "10.2.0.0/16"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.tg_peering_virginia_to_ohio.id
}

resource "aws_ec2_transit_gateway_route" "tg_route_to_virginia_from_ohio" {
  provider                       = aws.ohio
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tg_route_table_ohio.id
  destination_cidr_block         = "10.0.0.0/16"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.tg_peering_virginia_to_ohio.id
}
#######################  PEERING ####################### 



resource "aws_ec2_transit_gateway_peering_attachment" "tg_peering_virginia_to_ohio" {
  peer_region             = "us-east-2" # Ohio region
  provider                = aws.virginia
  transit_gateway_id      = aws_ec2_transit_gateway.tg_virginia.id
  peer_transit_gateway_id = aws_ec2_transit_gateway.tg_ohio.id
  peer_account_id         = "026090511431"
  tags = {
    Name = "${local.app_name_dashed}-TG-PEERING-VIR-TO-OH"
  }
}
resource "aws_ec2_transit_gateway_peering_attachment" "tg_peering" {
  peer_region             = "us-west-2"
  provider                = aws.virginia
  transit_gateway_id      = aws_ec2_transit_gateway.tg_virginia.id
  peer_transit_gateway_id = aws_ec2_transit_gateway.tg_oregon.id
  peer_account_id         = "026090511431"
  tags = {
    Name = "${local.app_name_dashed}-TG-PEERING-VIR-TO-OR"
  }
}



####################################### PEERING ACCEPTER ########################################

resource "aws_ec2_transit_gateway_peering_attachment_accepter" "tg_peering_accepter" {
  provider                      = aws.oregon
  transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment.tg_peering.id

  tags = {
    Name = "${local.app_name_dashed}-TG-PEERING-ACCEPTER-OR"
  }
}


resource "aws_ec2_transit_gateway_peering_attachment_accepter" "tg_peering_accepter_ohio" {
  provider                      = aws.ohio
  transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment.tg_peering_virginia_to_ohio.id

  tags = {
    Name = "${local.app_name_dashed}-TG-PEERING-ACCEPTER-OH"
  }
}