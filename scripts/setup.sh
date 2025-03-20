#!/bin/bash
# Atualiza os pacotes e instala Python, pip e venv
sudo apt update -y
sudo apt install -y python3 python3-pip python3-venv

# Cria e ativa um ambiente virtual (opcional)
python3 -m venv /home/ubuntu/venv
source /home/ubuntu/myenv/bin/activate

# Mensagem de teste para confirmar que o script rodou
echo "<h1>Python instalado com Terraform</h1>" > /home/ubuntu/index.html
nohup busybox httpd -f -p 8080 &