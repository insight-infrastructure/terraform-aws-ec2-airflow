# terraform-aws-ec2-airflow

## Features

This module sets up an airflow instance running the sequential executor on AWS. It mounts an EFS volume to that instance 
to sync airflow DAGs locally to the workers. 

To run example module:
```bash
cd examples/defaults
terraform apply 
cd ../..
make mount-efs
cp dag_example.py dags/
```

## Terraform Versions

For Terraform v0.12.0+

## Usage

```hcl-terraform
module "airflow" {
  source    = "../.."
  subnet_id = module.vpc.public_subnets[0]

  vpc_security_group_ids = [
  aws_security_group.this.id]

  public_key_path  = var.public_key_path
  private_key_path = var.private_key_path
}
```
## Examples

- [defaults](https://github.com/robc-io/terraform-aws-ec2-airflow/tree/master/examples/defaults)

## Known  Issues
No issue is creating limit on this module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| null | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| additional\_security\_groups | List of additional security groups | `list(string)` | `[]` | no |
| az\_num | The index of the default VPC AZ to put the instance in if the subnet is not supplied directly | `number` | `0` | no |
| certbot\_admin\_email | Admin email for SSL cert - must be in same domain | `string` | `""` | no |
| create | Boolean to make module or not | `bool` | `true` | no |
| create\_ansible | Boolean to make module or not | `bool` | `true` | no |
| create\_efs | Boolean to create EFS file system | `bool` | `true` | no |
| create\_instance\_profile | Bool to create IAM instance profile | `bool` | `true` | no |
| create\_security\_group | Bool to create security group | `bool` | `true` | no |
| domain\_name | The domain - example.com. Blank for no ssl / nginx | `string` | `""` | no |
| eip\_id | The elastic ip id to attach to active instance | `string` | `""` | no |
| hostname | The hostname - ie hostname.example.com | `string` | `"airflow"` | no |
| instance\_type | Instance type | `string` | `"t2.medium"` | no |
| key\_name | The key pair to import | `string` | `""` | no |
| monitoring\_enabled | Enable cloudwatch monitoring on node | `bool` | `true` | no |
| name | The name of the resources | `string` | `""` | no |
| network\_name | The network name, ie kusama / mainnet | `string` | `""` | no |
| open\_ports | List of ports to open. Basic setup needs 22 (ssh), 2049 (nfs-insecure), 8080 (airflow) | `list(string)` | <pre>[<br>  22,<br>  2049,<br>  8080<br>]</pre> | no |
| playbook\_vars | Extra vars to include, can be hcl or json | `map(string)` | `{}` | no |
| private\_key\_path | The path to the private ssh key | `string` | n/a | yes |
| public\_key\_path | The path to the public ssh key | `string` | n/a | yes |
| root\_volume\_size | Root volume size | `string` | `8` | no |
| ssh\_ips | List of IPs to restrict ssh traffic to | `list(string)` | n/a | yes |
| subnet\_id | The id of the subnet. Must be supplied if given vpc\_id | `string` | n/a | yes |
| subnet\_num | The index of the availability zone to deploy into | `number` | `0` | no |
| tags | Tags to associate with the instance. | `map(string)` | `{}` | no |
| user\_data | User data as raw text - not to be user with user\_data\_file\_path | `string` | `""` | no |
| user\_data\_file\_path | Path to user data file - not to be used with user\_data | `string` | `""` | no |
| vpc\_id | The vpc id to associate with.  Must be supplied if given subnet\_id | `string` | `""` | no |
| vpc\_security\_group\_ids | List of security groups - blank for default | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| dns\_name | EFS DNS name |
| fqdn | FQDN - eg airflow.example.com |
| instance\_id | The instance ID created |
| instance\_profile | The instance profile id |
| instance\_profile\_name | The instance profile name |
| key\_name | The key pair name created |
| mount\_target\_ids | List of EFS mount target IDs (one per Availability Zone) |
| public\_ip | The public IP of the instance created |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Testing
This module has been packaged with terratest tests

To run them:

1. Install Go
2. Run `make test-init` from the root of this repo
3. Run `make test` again from root

## Authors

Module managed by [robc-io](github.com/robc-io)

## Credits

- [Anton Babenko](https://github.com/antonbabenko)

## License

Apache 2 Licensed. See LICENSE for full details.