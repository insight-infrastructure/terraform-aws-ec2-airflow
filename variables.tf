########
# Label
########
variable "name" {
  description = "The name for the label"
  type        = string
  default     = "prometheus"
}

variable "environment" {
  description = "The environment"
  type        = string
  default     = ""
}

variable "namespace" {
  description = "The namespace to deploy into"
  type        = string
  default     = "prod"
}

variable "stage" {
  description = "The stage of the deployment"
  type        = string
  default     = "blue"
}

variable "network_name" {
  description = "The network name, ie kusama / mainnet"
  type        = string
  default     = "main"
}

variable "owner" {
  description = "Owner of the infrastructure"
  type        = string
  default     = ""
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
  description = "The id of the subnet"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of security groups"
  type        = list(string)
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