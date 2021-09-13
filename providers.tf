# ==================================================================
# Proposito:    declaramos que proveedor cloud queremos usar
# Autor:        DH
# Fecha:        30.07.21
# Version:      1.0
# ==================================================================

# ==================================================================
# Declaramos el Cloud Provider con el que queremos trabajar

terraform {
# Le decimos que queremos:
# a. la version del binario de terraform mayor o igual a 0.12
  required_version = ">=0.12"
  required_providers {
    aws = {
# Especificamos desde donde queremos descargar el binario:
      source = "hashicorp/aws"
# Le decimos que solo permitira:
# b. la version del binario del provider 3.20.0 (con cierta restriccion)
      version = "~> 3.20.0"
    }
  }
}
# ==================================================================

# ==================================================================
# Declaramos la region donde queremos levantar nuestra infra

provider "aws" {
  region = "us-east-1"
}
# ==================================================================
