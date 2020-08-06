module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "airflow"

  cidr = "10.0.0.0/16"

  azs = [
  "${var.aws_region}a"]
  private_subnets = [
  "10.0.1.0/24"]
  public_subnets = [
  "10.0.101.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  enable_dns_hostnames = true
}

resource "aws_security_group" "this" {
  vpc_id = module.vpc.vpc_id

  dynamic "ingress" {
    for_each = [
      22,
      8080,
    2049] # This is not ok for production
    content {
      from_port = ingress.value
      to_port   = ingress.value
      protocol  = "tcp"
      cidr_blocks = [
      "0.0.0.0/0"] # This is only for demo.  You really should lock this down to your ip - ie 1.2.3.4/32
    }
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
    "0.0.0.0/0"]
  }
}

resource "random_pet" "this" {
  length = 2
}

module "airflow" {
  source    = "../.."
  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnets[0]

  name = random_pet.this.id

  user_data_file_path = "${path.cwd}/example_user_data.sh"

  vpc_security_group_ids = [aws_security_group.this.id]

  public_key_path  = var.public_key_path
  private_key_path = var.private_key_path
}

output "public_ip" {
  value = module.airflow.public_ip
}
