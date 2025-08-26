resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr_block
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = merge( var.common_tags, { "Name" = "${local.nameprefix}-vpc"})
}

resource "aws_subnet" "public" {
  vpc_id                  =  aws_vpc.main.id
  count                   =  length(var.public_subnet_cidrs)
  cidr_block              =  element(var.public_subnet_cidrs, count.index)
  availability_zone       =  element(data.aws_availability_zones.available.names[*], count.index)
  map_public_ip_on_launch = true
  tags = merge(var.common_tags, { "Name" = "${local.nameprefix}-public-subnet-${count.index + 1}" },{ "kubernetes.io/role/elb" = "1" }, { "kubernetes.io/cluster/${local.cluster_name}" = "shared" })
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  count             = length(var.private_subnet_cidrs)
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(data.aws_availability_zones.available.names[*], count.index)
  tags = merge(var.common_tags, { "Name" = "${local.nameprefix}-private-subnet-${count.index + 1}" },{ "kubernetes.io/role/internal-elb" = "1" }, { "kubernetes.io/cluster/${local.cluster_name}" = "shared" })
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags   = merge(var.common_tags, { "Name" = "${local.nameprefix}-vpc-internet-gateway" })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = merge(var.common_tags, { "Name" = "${local.nameprefix}-public-route-table" })
}
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidrs)
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public[count.index].id
}



resource "aws_eip" "main" {
  domain     = "vpc"
  count      = var.create_nat ? 1 : 0
  tags       = merge(var.common_tags, { "Name" = "${local.nameprefix}-eip" })
  depends_on = [aws_internet_gateway.main]
}

resource "aws_nat_gateway" "main" {
  count         = var.create_nat ? 1 : 0
  subnet_id     = aws_subnet.public[0].id
  allocation_id = aws_eip.main[0].id
  tags = merge(var.common_tags, { "Name" = "${local.nameprefix}-vpc-nat-gateway" })
  depends_on = [aws_internet_gateway.main]
}

resource "aws_route_table" "private" {
  count  = var.create_nat ? 1 : 0
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[0].id
  }
  tags = merge(var.common_tags, { "Name" = "${local.nameprefix}-private-route-table" })
}

resource "aws_route_table_association" "private_subnets_association" {
  count          = var.create_nat ? length(var.private_subnet_cidrs) : 0
  route_table_id = aws_route_table.private[0].id
  subnet_id      = aws_subnet.private[count.index].id
}