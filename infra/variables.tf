variable env {
    type = string
}

variable "regiao_aws" {
  type = string
}

variable "chave_SSH" {
    type = string
}

variable "instancia" {
    type = string
}

variable "account_id" {
  description = "AWS Account ID for bucket naming"
  type        = string
}

variable "nome_ecr" {
  type = string
}