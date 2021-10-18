variable "name" {
  description = "Name of the DB instance."
  type        = string
}

variable "deploy_db_instance" {
  description = "Deploy DB instance."
  type        = bool
  default     = true
}

variable "enable_enhanced_monitoring" {
  description = "Enable enhanced monitoring on the DB instance."
  type        = bool
  default     = true
}

variable "monitoring_interval" {
  description = "Interval to monitor when enhanced monitoring is turned on."
  type        = number
  default     = 60
}

variable "enable_performance_insights" {
  description = "Enable performance insights."
  type        = bool
  default     = true
}

variable "enabled_cloudwatch_logs_exports" {
  description = "DB instance cloudwatch exports."
  type        = list(string)
  default     = ["postgresql", "upgrade"]
}

variable "multi_az" {
  description = "Enable multi az."
  type        = bool
  default     = false
}

variable "storage_encrypted" {
  description = "Encrypt storage"
  type        = bool
  default     = false
}

variable "vpc_security_group_ids" {
  description = "List of security groups to attach to the DB instance. If not provided, a default SG will be created."
  type        = list(any)
  default     = null
}

variable "vpc_id" {
  description = "The VPC to create the security group. Optional if vpc_security_group_ids is present."
  type        = string
  default     = null
}

variable "subnet_group" {
  description = "Subnet group for the DB instance. If not provided, a default subnet group will be created."
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "Subnets for the DB instance. Optional if subnet_group is present, otherwise required."
  type        = list(string)
  default     = null
}

variable "rds_password" {
  description = "Password for the default admin user. Optional, random password will be created if not present."
  type        = string
  default     = null
}

variable "rds_username" {
  description = "User name for the default admin user."
  type        = string
  default     = "postgres"
}

variable "rds_db_name" {
  description = "Name of the default database name."
  type        = string
  default     = "postgres"
}

variable "rds_snapshot_identifier" {
  description = "Create DB instances using the provided snapshot ID."
  type        = string
  default     = null
}

variable "rds_instance_class" {
  description = "Instance class to use for the DB instance."
  type        = string
  default     = "db.t2.micro"
}

variable "rds_engine" {
  description = "DB engine to use."
  type        = string
  default     = "postgres"
}

variable "rds_engine_version" {
  description = "Version to use for the DB instance engine."
  type        = string
  default     = "12.7"
}

variable "rds_backup_window" {
  description = "The daily time range (UTC) during which automated backups are created if they are enabled."
  type        = string
  default     = "04:00-04:30"
}

variable "rds_maintenance_window" {
  description = "The window to perform maintenance in."
  type        = string
  default     = "Sun:05:00-Sun:05:30"
}

variable "rds_backup_retention_period" {
  description = "Automated snapshot retention period."
  type        = number
  default     = 7
}

variable "rds_port" {
  description = "Port to use for the DB instance."
  type        = number
  default     = 5432
}

variable "rds_allocated_storage" {
  description = "Default DB instance storage size."
  type        = number
  default     = 20
}

variable "rds_max_allocated_storage" {
  description = "Max scaling for DB instance storage size."
  type        = number
  default     = 50
}

variable "tags" {
  description = "Tags to apply to applicable resources."
  type        = map(string)
  default     = {}
}
