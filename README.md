# terraform-aws-ec2-airflow

## Features

This module...

## Terraform Versions

For Terraform v0.12.0+

## Usage

```
module "this" {
    source = "github.com/robc-io/terraform-aws-ec2-airflow"

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
| eip\_id | The elastic ip id to attach to active instance | `string` | `""` | no |
| environment | The environment | `string` | `""` | no |
| instance\_type | Instance type | `string` | `"t2.medium"` | no |
| key\_name | The key pair to import | `string` | `""` | no |
| name | The name for the label | `string` | `"prometheus"` | no |
| namespace | The namespace to deploy into | `string` | `"prod"` | no |
| network\_name | The network name, ie kusama / mainnet | `string` | `"main"` | no |
| owner | Owner of the infrastructure | `string` | `""` | no |
| playbook\_vars | Extra vars to include, can be hcl or json | `map(string)` | `{}` | no |
| private\_key\_path | The path to the private ssh key | `string` | n/a | yes |
| public\_key\_path | The path to the public ssh key | `string` | n/a | yes |
| root\_volume\_size | Root volume size | `string` | `8` | no |
| stage | The stage of the deployment | `string` | `"blue"` | no |
| subnet\_id | The id of the subnet | `string` | n/a | yes |
| vpc\_security\_group\_ids | List of security groups | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| instance\_id | n/a |
| key\_name | n/a |
| public\_ip | n/a |

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