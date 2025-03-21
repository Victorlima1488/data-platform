module "aws-prod" {
    source = "../infra"
    instancia = "t2.micro"
    regiao_aws = "us-east-1"
    chave_SSH = "key-prod"
    env = "prod"
    account_id = "820242919674"
    nome_ecr = "infra-docker-repo"
}

output "IP-prod" {
    value = module.aws-prod.IP_publico
}