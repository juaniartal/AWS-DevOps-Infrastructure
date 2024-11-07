module "instance" {
  source            = "../modules/ec2-jumper"
  customer          = var.customer
  environment       = var.environment
  tags              = local.tags
  ami               = var.ami
  instance_type     = var.instance_type
  region            = var.region
  key_name          = module.key_pair.key_name
  network_interface_id = aws_network_interface.bastion_eni.id
}

module "eip" {
  source      = "../modules/eip-jumper"
  instance_id = module.instance.instance_id
  customer    = var.customer
  environment = var.environment
  tags        = local.tags
}



resource "aws_network_interface" "bastion_eni" {
  subnet_id   = data.terraform_remote_state.vpc.outputs.public_subnet_id
  security_groups = [aws_security_group.bastion_sg.id]

  tags = merge(
    { Name = "${var.customer}-${var.environment}-bastion-eni" },
    local.tags
  )
}