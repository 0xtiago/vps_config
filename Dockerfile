FROM ubuntu:latest

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y wget curl ca-certificates zsh tmux git

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


# Copiando o certificado do BurpSuite para o container, se ele existir
COPY burp_cert.crt /usr/local/share/ca-certificates/burp_cert.crt

# Configura o certificado apenas se o certificado estiver presente
RUN if [ -f /usr/local/share/ca-certificates/burp_cert.crt ]; then \
    update-ca-certificates; \
    else \
    echo "Certificado BurpSuite não encontrado. Pulando a importação do certificado."; \
    fi

# Instalando o ohmyzsh e configurando o zsh como bash padrão
RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" && \
    chsh -s /bin/zsh

# Instalando o ohmytmux
RUN git clone https://github.com/gpakosz/.tmux.git /root/.tmux && \
    ln -s -f /root/.tmux/.tmux.conf /root/.tmux.conf && \
    cp /root/.tmux/.tmux.conf.local /root/

# Para manter o container em execução
CMD ["tail", "-f", "/dev/null"]
