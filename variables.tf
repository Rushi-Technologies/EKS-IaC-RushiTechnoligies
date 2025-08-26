variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "flipkart"
}

variable "company_name" {
  description = "The name of the company"
  type        = string
  default     = "Rushi Technologies"
}

variable "environment" {
  description = "The environment for the deployment"
  type        = string
  default     = "dev"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {
    Project     = "lic"
    Company     = "Rushi Technologies"
    Environment =  "dev"
  }
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.0.0/20","10.0.16.0/20"]
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.32.0/20","10.0.48.0/20"]
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "lic-eks-cluster"
}

variable "create_nat" {
  description = "Flag to create a NAT gateway"
  type        = bool
  default     = true
}

variable "eks_cluster_role_name" {
    description = "The name of the IAM role for the EKS cluster"
    type        = string
    default     = "lic-eks-cluster-role"
}

variable "endpoint_private_access" {
  description = "Enable private access to the EKS API server"
  type        = bool
  default     = true     
}

variable "endpoint_public_access" {
  description = "Enable public access to the EKS API server"
  type        = bool
  default     = true     
}

variable "eks_version" {
  description = "The version of the EKS cluster"
  type        = string
  default     = "1.33"
}

variable "eks_worker_role_policy_arns" {
  description = "List of IAM policy ARNs to attach to the EKS worker role"
  type        = list(string)
  default     = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  ]
}

variable "node_group_disk_size" {
  description = "Disk size for the EKS node group"
  type        = number
  default     = 20
}

variable "node_group_desired_size" {
  description = "Desired size for the EKS node group"
  type        = number
  default     = 2
}
variable "node_group_min_size" {
  description = "Minimum size for the EKS node group"
  type        = number
  default     = 1    
}
variable "node_group_max_size" {
  description = "Maximum size for the EKS node group"
  type        = number
  default     = 3     
}

variable "node_group_instance_type" {
  description = " Instance type for the EKS node group"
  type        = string
  default     = "t3.small"
}