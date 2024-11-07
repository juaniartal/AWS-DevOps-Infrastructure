project               = "CLARINWALLET"
environment           = "DEV"
customer              = "CLARIN"
sso_profile           = "academy-box-1"
region                = "us-east-1"
db_name               = "mydb"
db_username           = "juani"
backup_retention_period = 7
backup_window         = "02:00-03:00"
maintenance_window    = "Mon:03:00-Mon:04:00"
ami = "ami-0ae8f15ae66fe8cda"
instance_type = "t3.micro"

db_instance_config = {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0.35"
  instance_class         = "db.t3.micro"
}

