FROM ubuntu:latest

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y wget curl

WORKDIR /workdir

# Executa script básico de instalação de VPS
RUN wget -O - "https://raw.githubusercontent.com/0xtiago/vps_config/main/run_basic.sh" | bash

# Mantem o container em execução
CMD ["tail", "-f", "/dev/null"]
