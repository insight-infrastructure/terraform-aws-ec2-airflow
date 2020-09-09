
resource "random_pet" "this" {
  length = 2
}

module "airflow" {
  source = "../.."

  name = random_pet.this.id

  domain_name = "insight-infra.de"
  hostname    = "airflow"

  open_ports = [22, 443, 80]

  user_data_file_path = "${path.cwd}/example_user_data.sh"

  public_key_path  = var.public_key_path
  private_key_path = var.private_key_path
}

output "public_ip" {
  value = module.airflow.public_ip
}
