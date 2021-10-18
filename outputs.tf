output "aws_iam_role" {
  description = "Outputs of the IAM role created."

  value = {
    enhanced_monitoring = var.enable_enhanced_monitoring ? aws_iam_role.enhanced_monitoring[0] : null
  }
}

output "aws_security_group" {
  description = "Outputs of the security group created."

  value = {
    rds = var.vpc_security_group_ids == null ? aws_security_group.rds[0] : null
  }
}

output "aws_db_subnet_group" {
  description = "Outputs of the DB subnet group created."

  value = {
    this = var.subnet_group == null ? aws_db_subnet_group.this[0] : null
  }
}

output "aws_db_instance" {
  description = "Outputs of the DB instance created."

  value = {
    this = var.deploy_db_instance ? aws_db_instance.this[0] : null
  }
}
