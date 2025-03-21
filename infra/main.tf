terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.regiao_aws
}

#Criação de Instância
resource "aws_instance" "app_server" {
  ami           = "ami-04b4f1a9cf54c11d0"
  instance_type = var.instancia
  key_name      = var.chave_SSH

  vpc_security_group_ids = [aws_security_group.acesso_geral.id]

  user_data = file("../scripts/setup.sh")

  tags = {
    Name = "${var.env}-aws"
  }
}

#Criação de Par de chave para conexão SSH
resource "aws_key_pair" "chaveSSH" {
  key_name = var.chave_SSH
  public_key = file("${var.chave_SSH}.pub")
}

#Criação de Grupos de segurança para Instâncias
resource "aws_security_group" "acesso_geral" {
  name = "acesso_geral_${var.env}"
  description = "grupo de seguranca do ambiente ${var.env}"
  ingress {
    cidr_blocks = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = [ "::/0" ]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }
  egress {
    cidr_blocks = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = [ "::/0" ]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }
  tags = {
    Name = "acesso_geral_${var.env}"
  }
}

#Criação de Bucket
resource "aws_s3_bucket" "bronze" {
  bucket = "${var.env}-datalake-bronze-${var.account_id}"

  tags = {
    Name        = "${var.env}-datalake-bronze"
    Environment = var.env
    Layer = "bronze"
  }
}

output "IP_publico" {
  value = aws_instance.app_server.public_ip
}

# Repositório ECR
resource "aws_ecr_repository" "repositorio" {
  name = "${var.env}-${var.nome_ecr}"
}