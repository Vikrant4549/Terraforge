// VPC
resource "aws_vpc" "terraforge_vpc" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support   = true
    enable_dns_hostnames = true

    tags = {
      Name = "terraforge-vpc"
    }
}


// Public Submet
resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.terraforge_vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true

    tags = {
        Name = "public-subnet"
    }
}

/* Private Subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = false
}
*/

// Internet Gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.terraforge_vpc.id

    tags = {
      Name = "terraforge-igw"
    }
}

// Route Table
resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.terraforge_vpc.id

    tags = {
        Name = "terraforge-public-rt"
    }
}

// Routes
resource "aws_route" "public_internet_route" {
    route_table_id = aws_route_table.public_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
}


// This subnet must follow this route table
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}



// Security Group
resource "aws_security_group" "terraforge_sg" {
  name        = "terraforge-sg"
  description = "Allow HTTP and SSH"
  vpc_id      = aws_vpc.terraforge_vpc.id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraforge-sg"
  }
}
