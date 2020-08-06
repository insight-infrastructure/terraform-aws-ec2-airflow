variable "name" {
  description = "A unique name to give all the resources"
  type        = string
  default     = "airflow"
}

variable "tags" {
  description = "Tags to attach to all resources"
  type        = map(string)
  default     = {}
}

variable "create_efs" {
  description = "Boolean to create EFS file system"
  type        = bool
  default     = true
}

######
# Data
######
variable "eip_id" {
  description = "The elastic ip id to attach to active instance"
  type        = string
  default     = ""
}

variable "subnet_id" {
  description = "The id of the subnet - blank for default"
  type        = string
  default     = ""
}

variable "vpc_security_group_ids" {
  description = "List of security groups - blank for default"
  type        = list(string)
  default     = []
}

#####
# ec2
#####
variable "key_name" {
  description = "The key pair to import"
  type        = string
  default     = ""
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