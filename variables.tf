variable "location" {
  description = "Variável que indica a região onde os recursos serão criados"
  type        = string
  default     = "West US 3"
  #sensitive = true
}

variable "aws_pub_key" {
  description = "Public Key para VM na AWS"
  type        = string 
}

variable "azure_pub_key" {
  description = "Public Key para VM na Azure"
  type        = string 
}