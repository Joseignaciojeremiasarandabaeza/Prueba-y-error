# 1. Configuración del Provider (AWS)
provider "aws" {
  region = "us-east-1" # Asegúrate que coincida con tu región de pruebas
}

# 2. Declaración de Variables (Necesarias para recibir el input del pipeline)
variable "environment" {
  description = "Entorno proveniente del pipeline (Production, Staging, etc.)"
  type        = string
  default     = "Dev" 
}

# 3. Infraestructura: Bucket S3 para el Frontend
# El nombre del bucket debe ser único globalmente, por eso usamos el entorno
resource "aws_s3_bucket" "techmarket_app_bucket" {
  # Nombre ajustado a 63 caracteres exactos (considerando 'production')
  # Eliminado el caracter '<' que rompe la validación de DNS de S3
  bucket = "techmarket-app-${lower(var.environment)}-202623457csgfhvsdzhgjstuey5" 

  tags = {
    Name        = "TechMarket-App-Resources"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# 4. Infraestructura: Instancia EC2 (Capa Gratuita)
# Usamos un recurso sencillo para validar que el despliegue funciona
resource "aws_instance" "techmarket_server" {
  ami           = "ami-01b14b7ad41e17ba4" # Amazon Linux 2 en us-east-1
  instance_type = "t2.micro"             # Free Tier

  tags = {
    Name        = "Server-${var.environment}"
    Project     = "TechMarket"
  }
}

# 5. Salidas (Outputs)
# Esto aparecerá en los logs de tu GitHub Action al finalizar
output "s3_bucket_name" {
  value = aws_s3_bucket.techmarket_app_bucket.id
}

output "instance_public_ip" {
  value = aws_instance.techmarket_server.public_ip
}
