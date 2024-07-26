FROM ubuntu:latest

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y wget curl ca-certificates zsh

WORKDIR /workdir

# Configuração para o zsh history
RUN echo 'export HISTFILE=/root/.zsh_history' >> /root/.zshrc && \
    echo 'export HISTSIZE=1000' >> /root/.zshrc && \
    echo 'export HISTFILESIZE=2000' >> /root/.zshrc && \
    echo 'export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"' >> /root/.zshrc

# Criar o arquivo .bash_history
RUN touch /root/.zsh_history

# Executa script básico de instalação de configuração do container
RUN wget -O - "https://raw.githubusercontent.com/0xtiago/vps_config/main/run_basic.sh" | bash


# Copia certificado do BurpSuite para o container, se ele existir
COPY burp_cert.crt /usr/local/share/ca-certificates/burp_cert.crt

# Atualiza os certificados apenas se o certificado estiver presente
RUN if [ -f /usr/local/share/ca-certificates/burp_cert.crt ]; then \
    update-ca-certificates; \
    else \
    echo "Certificado BurpSuite não encontrado. Pulando a importação do certificado."; \
    fi

# Zsh como shell padrão
RUN chsh -s /bin/zsh

# Mantem o container em execução
CMD ["tail", "-f", "/dev/null"]
