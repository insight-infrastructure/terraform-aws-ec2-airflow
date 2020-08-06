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
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| az\_num | The index of the default VPC AZ to put the instance in if the subnet is not supplied directly | `number` | `0` | no |
| create\_efs | Boolean to create EFS file system | `bool` | `true` | no |
| eip\_id | The elastic ip id to attach to active instance | `string` | `""` | no |
| instance\_type | Instance type | `string` | `"t2.medium"` | no |
| key\_name | The key pair to import | `string` | `""` | no |
| name | A unique name to give all the resources | `string` | `"airflow"` | no |
| playbook\_vars | Extra vars to include, can be hcl or json | `map(string)` | `{}` | no |
| private\_key\_path | The path to the private ssh key | `string` | n/a | yes |
| public\_key\_path | The path to the public ssh key | `string` | n/a | yes |
| root\_volume\_size | Root volume size | `string` | `8` | no |
| subnet\_id | The id of the subnet - blank for default | `string` | `""` | no |
| tags | Tags to attach to all resources | `map(string)` | `{}` | no |
| user\_data | User data as raw text - not to be user with user\_data\_file\_path | `string` | `""` | no |
| user\_data\_file\_path | Path to user data file - not to be used with user\_data | `string` | `""` | no |
| vpc\_security\_group\_ids | List of security groups - blank for default | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| dns\_name | EFS DNS name |
| instance\_id | The instance ID created |
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