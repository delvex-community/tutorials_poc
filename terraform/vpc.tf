resource "aws_vpc" "ashuvpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "ashu-vpcnew"
  }
}

 
# creating Internet gateway 

resource "aws_internet_gateway" "ashugw" {
  vpc_id = aws_vpc.ashuvpc.id

  tags = {
    Name = "ashugw1"
  }
}

# creating route table

resource "aws_route_table" "ashuroute" {
  vpc_id = aws_vpc.ashuvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ashugw.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.ashugw.id
  }

  tags = {
    Name = "ashu-route"
  }
}

# creating subnet

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.ashuvpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "pubsub-1"
  }
}

# Route table association 
resource "aws_route_table_association" "ashurouteasso" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.ashuroute.id
}

