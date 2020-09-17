variable "create" {
  description = "Boolean to make module or not"
  type        = bool
  default     = true
}

variable "create_ansible" {
  description = "Boolean to make module or not"
  type        = bool
  default     = true
}

variable "create_security_group" {
  description = "Bool to create security group"
  type        = bool
  default     = true
}

variable "create_instance_profile" {
  description = "Bool to create IAM instance profile"
  type        = bool
  default     = true
}

variable "domain_name" {
  description = "The domain - example.com. Blank for no ssl / nginx"
  type        = string
  default     = ""
}

variable "hostname" {
  description = "The hostname - ie hostname.example.com"
  type        = string
  default     = "airflow"
}

########
# Label
########
variable "network_name" {
  description = "The network name, ie kusama / mainnet"
  type        = string
  default     = ""
}

variable "name" {
  description = "The name of the resources"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to associate with the instance."
  type        = map(string)
  default     = {}
}

#########
# Network
#########
variable "subnet_id" {
  description = "The id of the subnet. Must be supplied if given vpc_id"
  type        = string
  default     = null
}

variable "vpc_id" {
  description = "The vpc id to associate with.  Must be supplied if given subnet_id"
  type        = string
  default     = ""
}

variable "subnet_num" {
  description = "The index of the availability zone to deploy into"
  type        = number
  default     = 0
}

#################
# Security Groups
#################
variable "additional_security_groups" {
  description = "List of additional security groups"
  type        = list(string)
  default     = []
}

variable "open_ports" {
  description = "List of ports to open. Basic setup needs 22 (ssh), 2049 (nfs-insecure), 8080 (airflow)"
  type        = list(string)
  default     = [22, 2049, 8080]
}

variable "ssh_ips" {
  description = "List of IPs to restrict ssh traffic to"
  type        = list(string)
  default     = null
}

variable "eip_id" {
  description = "The elastic ip id to attach to active instance"
  type        = string
  default     = ""
}

variable "vpc_security_group_ids" {
  description = "List of security groups - blank for default"
  type        = list(string)
  default     = []
}

variable "certbot_admin_email" {
  description = "Admin email for SSL cert - must be in same domain"
  type        = string
  default     = ""
}

#####
# efs
#####
variable "create_efs" {
  description = "Boolean to create EFS file system"
  type        = bool
  default     = true
}

#####
# ec2
#####
variable "key_name" {
  description = "The key pair to import"
  type        = string
  default     = ""
}

variable "monitoring_enabled" {
  description = "Enable cloudwatch monitoring on node"
  type        = bool
  default     = true
}

variable "root_volume_size" {
  description = "Root volume size"
  type        = string
  default     = 8
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t2.medium"
}

variable "public_key_path" {
  description = "The path to the public ssh key"
  type        = string
}

variable "private_key_path" {
  description = "The path to the private ssh key"
  type        = string
}

variable "playbook_vars" {
  description = "Extra vars to include, can be hcl or json"
  type        = map(string)
  default     = {}
}

variable "user_data" {
  description = "User data as raw text - not to be user with user_data_file_path"
  type        = string
  default     = ""
}

variable "user_data_file_path" {
  description = "Path to user data file - not to be used with user_data"
  type        = string
  default     = ""
}

variable "az_num" {
  description = "The index of the default VPC AZ to put the instance in if the subnet is not supplied directly"
  type        = number
  default     = 0
}

### Airflow S3 Outputs

variable "create_s3_output_bucket" {
  description = "Bool to enable creation of Airflow outputs bucket in S3"
  type        = bool
  default     = true
}

variable "s3_output_bucket_name" {
  description = "*Unique* name of S3 bucket for Airflow outputs"
  type        = string
}