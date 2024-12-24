# modules/rds/main.tf
resource "aws_db_subnet_group" "sub_grp" {
  name_prefix = "${var.subnet_group.name}-"  # Use name_prefix instead of fixed name
  subnet_ids  = coalesce(var.subnet_group.subnet_ids, var.private_subnet_ids)
  tags        = var.subnet_group.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_db_instance" "rds_instance" {
  for_each = var.rds_instances
  
  identifier           = each.value.identifier
  db_name              = each.value.db_name

  allocated_storage    = each.value.allocated_storage
  storage_type         = each.value.storage_type
  engine               = each.value.engine
  engine_version       = each.value.engine_version
  instance_class       = each.value.instance_class
  username             = each.value.username
  password             = each.value.password
  parameter_group_name = each.value.parameter_group_name
  db_subnet_group_name = aws_db_subnet_group.sub_grp.name  # Use the single subnet group
  skip_final_snapshot  = each.value.skip_final_snapshot
  publicly_accessible  = each.value.publicly_accessible
  multi_az             = each.value.multi_az

  vpc_security_group_ids = each.value.vpc_security_group_ids

  tags = each.value.tags
}