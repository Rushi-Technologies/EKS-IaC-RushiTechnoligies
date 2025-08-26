locals {
  nameprefix = "${var.project_name}-${var.environment}"
  cluster_name = "${var.cluster_name}-${var.environment}"
}