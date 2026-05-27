# variables.tf
variable "aws_endpoint" {
  description = "Endpoint customizado para emulador local (Floci). Deixe null para AWS real."
  type        = string
  default     = null
}

variable "aws_region" {
  description = "Região AWS"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Ambiente de deploy (local, dev, staging, prod)"
  type        = string
  validation {
    condition     = contains(["local", "dev", "staging", "prod"], var.environment)
    error_message = "Environment deve ser local, dev, staging ou prod."
  }
}O

