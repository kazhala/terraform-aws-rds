# terraform-aws-rds

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.60 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.63.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_iam_role.enhanced_monitoring](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.enhanced_monitoring](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.rds_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [random_id.rds_final_snapshot](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_password.rds_master](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_iam_policy_document.enhanced_monitoring](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deploy_db_instance"></a> [deploy\_db\_instance](#input\_deploy\_db\_instance) | Deploy DB instance. | `bool` | `true` | no |
| <a name="input_enable_enhanced_monitoring"></a> [enable\_enhanced\_monitoring](#input\_enable\_enhanced\_monitoring) | Enable enhanced monitoring on the DB instance. | `bool` | `true` | no |
| <a name="input_enable_performance_insights"></a> [enable\_performance\_insights](#input\_enable\_performance\_insights) | Enable performance insights. | `bool` | `true` | no |
| <a name="input_enabled_cloudwatch_logs_exports"></a> [enabled\_cloudwatch\_logs\_exports](#input\_enabled\_cloudwatch\_logs\_exports) | DB instance cloudwatch exports. | `list(string)` | <pre>[<br>  "postgresql",<br>  "upgrade"<br>]</pre> | no |
| <a name="input_monitoring_interval"></a> [monitoring\_interval](#input\_monitoring\_interval) | Interval to monitor when enhanced monitoring is turned on. | `number` | `60` | no |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | Enable multi az. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the DB instance. | `string` | n/a | yes |
| <a name="input_rds_allocated_storage"></a> [rds\_allocated\_storage](#input\_rds\_allocated\_storage) | Default DB instance storage size. | `number` | `20` | no |
| <a name="input_rds_backup_retention_period"></a> [rds\_backup\_retention\_period](#input\_rds\_backup\_retention\_period) | Automated snapshot retention period. | `number` | `7` | no |
| <a name="input_rds_backup_window"></a> [rds\_backup\_window](#input\_rds\_backup\_window) | The daily time range (UTC) during which automated backups are created if they are enabled. | `string` | `"04:00-04:30"` | no |
| <a name="input_rds_db_name"></a> [rds\_db\_name](#input\_rds\_db\_name) | Name of the default database name. | `string` | `"postgres"` | no |
| <a name="input_rds_engine"></a> [rds\_engine](#input\_rds\_engine) | DB engine to use. | `string` | `"postgres"` | no |
| <a name="input_rds_engine_version"></a> [rds\_engine\_version](#input\_rds\_engine\_version) | Version to use for the DB instance engine. | `string` | `"12.7"` | no |
| <a name="input_rds_instance_class"></a> [rds\_instance\_class](#input\_rds\_instance\_class) | Instance class to use for the DB instance. | `string` | `"db.t2.micro"` | no |
| <a name="input_rds_maintenance_window"></a> [rds\_maintenance\_window](#input\_rds\_maintenance\_window) | The window to perform maintenance in. | `string` | `"Sun:05:00-Sun:05:30"` | no |
| <a name="input_rds_max_allocated_storage"></a> [rds\_max\_allocated\_storage](#input\_rds\_max\_allocated\_storage) | Max scaling for DB instance storage size. | `number` | `50` | no |
| <a name="input_rds_password"></a> [rds\_password](#input\_rds\_password) | Password for the default admin user. Optional, random password will be created if not present. | `string` | `null` | no |
| <a name="input_rds_port"></a> [rds\_port](#input\_rds\_port) | Port to use for the DB instance. | `number` | `5432` | no |
| <a name="input_rds_snapshot_identifier"></a> [rds\_snapshot\_identifier](#input\_rds\_snapshot\_identifier) | Create DB instances using the provided snapshot ID. | `string` | `null` | no |
| <a name="input_rds_username"></a> [rds\_username](#input\_rds\_username) | User name for the default admin user. | `string` | `"postgres"` | no |
| <a name="input_storage_encrypted"></a> [storage\_encrypted](#input\_storage\_encrypted) | Encrypt storage | `bool` | `false` | no |
| <a name="input_subnet_group"></a> [subnet\_group](#input\_subnet\_group) | Subnet group for the DB instance. If not provided, a default subnet group will be created. | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Subnets for the DB instance. Optional if subnet\_group is present, otherwise required. | `list(string)` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to applicable resources. | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC to create the security group. Optional if vpc\_security\_group\_ids is present. | `string` | `null` | no |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | List of security groups to attach to the DB instance. If not provided, a default SG will be created. | `list(any)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_db_instance"></a> [aws\_db\_instance](#output\_aws\_db\_instance) | Outputs of the DB instance created. |
| <a name="output_aws_db_subnet_group"></a> [aws\_db\_subnet\_group](#output\_aws\_db\_subnet\_group) | Outputs of the DB subnet group created. |
| <a name="output_aws_iam_role"></a> [aws\_iam\_role](#output\_aws\_iam\_role) | Outputs of the IAM role created. |
| <a name="output_aws_security_group"></a> [aws\_security\_group](#output\_aws\_security\_group) | Outputs of the security group created. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
