# ==================================================================
# Proposito:    declaramos todas las variables que vamos a usar
# Autor:        DH
# Fecha:        30.07.21
# Version:      1.0
# ==================================================================

variable "aws_region_id" {
    description = "la region"
    type        = string
    default = "us-east-1"
}
variable "main_vpc_cidr" {
    description = "Nuestro Security Group"
    type        = string    
    default = "10.0.0.0/24"
}

variable "public_subnets" {
    description = "subnet con acceso a internet"
    type        = string
    default = "10.0.0.128/26"
}

variable "private_subnets" {
    description = "subnet sin acceso a internet"
    type        = string
    default = "10.0.0.192/26"
}
# ==================================================================
