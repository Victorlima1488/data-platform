module "aws-dev" {
    source = "../infra"
    instancia = "t2.micro"
    regiao_aws = "us-east-1"
    chave_SSH = "key-dev"
    env = "dev"
    account_id = "820242919674"
    nome_ecr = "infra-docker-repo"
}

output "IP-dev" {
    value = module.aws-dev.IP_publico
}