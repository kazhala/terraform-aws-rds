data "aws_iam_policy_document" "enhanced_monitoring" {
  statement {
    actions = ["sts:AssumeRole", ]

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "enhanced_monitoring" {
  count = var.enable_enhanced_monitoring ? 1 : 0

  name_prefix        = "${substr("${var.name}-rds-monitoring", 0, 37)}-"
  assume_role_policy = data.aws_iam_policy_document.enhanced_monitoring.json

  tags = merge({ "Name" = "${var.name}-rds-monitoring" }, var.tags)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role_policy_attachment" "enhanced_monitoring" {
  count = var.enable_enhanced_monitoring ? 1 : 0

  role       = aws_iam_role.enhanced_monitoring[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

# tfsec:ignore:AWS018
resource "aws_security_group" "rds" {
  # checkov:skip=CKV_AWS_23:No description.
  count = var.vpc_security_group_ids == null ? 1 : 0

  name_prefix = "${var.name}-rds-"
  vpc_id      = var.vpc_id

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

# tfsec:ignore:AWS018
# tfsec:ignore:AWS007
resource "aws_security_group_rule" "rds_egress" {
  # checkov:skip=CKV_AWS_23:No description.
  count = var.vpc_security_group_ids == null ? 1 : 0

  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.rds[0].id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_db_subnet_group" "this" {
  count = var.subnet_group == null ? 1 : 0

  name_prefix = "${var.name}-"
  subnet_ids  = var.subnet_ids

  tags = merge({ Name = var.name }, var.tags)
}

resource "random_password" "rds_master" {
  length  = 12
  special = false
}

resource "random_id" "rds_final_snapshot" {
  byte_length = 4

  keepers = {
    snashot_identifier = var.rds_snapshot_identifier
    rds_username       = var.rds_username
    rds_password       = var.rds_password
    rds_db_name        = var.rds_db_name
    rds_engine         = var.rds_engine
    rds_engine_version = var.rds_engine_version
    rds_port           = var.rds_port
  }
}

# tfsec:ignore:AWS052
# tfsec:ignore:AWS053
resource "aws_db_instance" "this" {
  # checkov:skip=CKV_AWS_157:Optional multi az.
  # checkov:skip=CKV_AWS_16:Optional encryption.
  # checkov:skip=CKV2_AWS_30:Optional query logging.
  count = var.deploy_db_instance ? 1 : 0

  identifier_prefix = "${var.name}-"

  instance_class            = var.rds_instance_class
  engine                    = var.rds_engine
  engine_version            = var.rds_engine_version
  snapshot_identifier       = var.rds_snapshot_identifier
  final_snapshot_identifier = "${var.name}-${random_id.rds_final_snapshot.hex}"
  multi_az                  = var.multi_az
  storage_encrypted         = var.storage_encrypted

  backup_window           = var.rds_backup_window
  maintenance_window      = var.rds_maintenance_window
  backup_retention_period = var.rds_backup_retention_period

  username = var.rds_username
  password = var.rds_password
  name     = var.rds_db_name
  port     = var.rds_port

  allocated_storage     = var.rds_allocated_storage
  max_allocated_storage = var.rds_max_allocated_storage

  db_subnet_group_name   = var.subnet_group == null ? aws_db_subnet_group.this[0].name : var.subnet_group
  vpc_security_group_ids = var.vpc_security_group_ids == null ? [aws_security_group.rds[0].id] : var.vpc_security_group_ids

  monitoring_interval             = var.enable_enhanced_monitoring ? var.monitoring_interval : null
  monitoring_role_arn             = var.enable_enhanced_monitoring ? aws_iam_role.enhanced_monitoring[0].arn : null
  performance_insights_enabled    = var.enable_performance_insights
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  tags = merge({ Name = var.name }, var.tags)

  lifecycle {
    create_before_destroy = true
  }
}
