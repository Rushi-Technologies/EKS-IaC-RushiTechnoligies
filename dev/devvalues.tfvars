environment = "dev"
vpc_cidr_block = "192.168.0.0/16"
common_tags = {
  Project     = "lic"
  Company     = "Rushi Technologies"
  Environment = "dev"
}
public_subnet_cidrs = ["192.168.0.0/20", "192.168.16.0/20"]
private_subnet_cidrs = ["192.168.32.0/20", "192.168.48.0/20"]
cluster_name = "lic-eks-cluster"
create_nat = true
eks_version = "1.33"
eks_cluster_role_name = "lic-eks-cluster-role-dev"
node_group_disk_size = 20
node_group_instance_type = "t3.micro"
node_group_desired_size = 2
node_group_max_size = 3
node_group_min_size = 2