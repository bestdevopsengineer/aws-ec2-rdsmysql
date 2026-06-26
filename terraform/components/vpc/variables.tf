variable "region" {
  type    = string
  default = "us-east-1"
}

variable "env" {
  description = "Environment (dev, stg, prod)"
  type        = string
  default     = "dev"
}
