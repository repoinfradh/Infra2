# ==================================================================
# Proposito:    crear infraestructura AWS
# Autor:        DH
# Fecha:        30.07.21
# Version:      1.0
# ==================================================================


# ==================================================================
# Creamos nuestro VPC
resource "aws_vpc" "Main" {                # usamos el bloque "resource", el "provider element" y una "etiqueta"
  cidr_block       = var.main_vpcz_cidr     # le pasamos por variable el CIDR block que quiero que use
  instance_tenancy = "default"
  tags = {
  Name = "My_VPC"
  }
}
# ==================================================================

# ==================================================================
# Creamos un Internet Gateway "Y" lo asociamos al VPC que se acaba de crear
resource "aws_internet_gateway" "IGW" {    # Internet Gateway
  vpc_id =  aws_vpc.Main.id               # vamos a conocer el vpc_id solo cuando el VPC se haya creado
  tags = {
  Name = "IGW"
  }
}
# ==================================================================

# ==================================================================
# Creamos la subnet publica
resource "aws_subnet" "public_subnets" {    # creamos las subnets publicas
  vpc_id =  aws_vpc.Main.id
  cidr_block = var.public_subnets        # CIDR block para mis public subnets
  tags = {
  Name = "Public Subnet"
  }
}
# ==================================================================

# ==================================================================
# Creamos la subnet privada                   # creamos nuestras private subnets
resource "aws_subnet" "private_subnets" {
  vpc_id =  aws_vpc.Main.id
  cidr_block = var.private_subnets          # CIDR block para mis subnets privadas
  tags = {
    Name = "Private Subnet"
  }
}
# ==================================================================

# ==================================================================
# Tabla de ruteo para la subnet publica
resource "aws_route_table" "Public_RT" {    # Creamos nuestro Route Table para la subnet publica
  vpc_id =  aws_vpc.Main.id
  route {
    cidr_block = "0.0.0.0/0"               # Declaramos el trafico desde la subnet publica llega a Internet desde el Internet Gateway
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {
    Name = "Tabla de Ruteo Publica"
  }
}
# ==================================================================

# ==================================================================
# Creacion del NAT Gateway usando subnet_id y allocation_id
resource "aws_nat_gateway" "NAT_GW" {
  allocation_id = aws_eip.NAT_EIP.id
  subnet_id = aws_subnet.public_subnets.id
  tags = {
    Name = "NAT Gateway + EIP alocadas a la subnet publica"
  }
}
# ==================================================================

# ==================================================================
# Tabla de ruteo para la subnet privada
resource "aws_route_table" "Private_RT" {    # Creating RT for Private Subnet
  vpc_id = aws_vpc.Main.id
  route {
    cidr_block = "0.0.0.0/0"             # Trafico proviniendo desde la subnet privadas llegando a Internet via NAT Gateway
    nat_gateway_id = aws_nat_gateway.NAT_GW.id
  }
  tags = {
  Name = "Tabla de Ruteo Privada"
  }
}
# ==================================================================

# ==================================================================
# Asociacion de tabla de ruteo con la subnet publica
resource "aws_route_table_association" "Public_RT_Association" {
  subnet_id = aws_subnet.public_subnets.id
  route_table_id = aws_route_table.Public_RT.id
}
# ==================================================================

# ==================================================================
# Asociacion de tabla de ruteo con la subnet privada
resource "aws_route_table_association" "Private_RT_Association" {
  subnet_id = aws_subnet.private_subnets.id
  route_table_id = aws_route_table.Private_RT.id
}
# ==================================================================

# ==================================================================
resource "aws_eip" "NAT_EIP" {
  vpc   = false
  tags = {
  Name = "NAT con elastic IP"
  }
}
# ==================================================================