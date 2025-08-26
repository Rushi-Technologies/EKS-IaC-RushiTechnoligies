data "aws_iam_policy_document" "assume_role_policy_cluster" {
  statement {
    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  } 
}

data "aws_iam_policy_document" "assume_role_policy_worker" {
  statement {
    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_availability_zones" "available" {
  state = "available" 
}