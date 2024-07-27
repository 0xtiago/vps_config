FROM ubuntu:latest

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y wget curl ca-certificates zsh tmux git

WORKDIR /workdir

# Configuração para o zsh history
RUN echo 'export HISTFILE=/root/.zsh_history' >> /root/.zshrc && \
    echo 'export HISTSIZE=1000' >> /root/.zshrc && \
    echo 'export HISTFILESIZE=2000' >> /root/.zshrc && \
    echo 'setopt inc_append_history' >> /root/.zshrc && \
    echo 'setopt share_history' >> /root/.zshrc && \
    echo 'setopt append_history' >> /root/.zshrc

# Cria .zsh_history
# Vc precisa criar o .zsh_history localmente para o mapeamento!
# $ touch .zsh_history
RUN touch /root/.zsh_history

# Executa script básico de instalação de configuração do container
RUN wget -O - "https://raw.githubusercontent.com/0xtiago/vps_config/main/run_basic.sh" | bash


# Copiando o certificado do BurpSuite para o container, se ele existir
COPY burp_cert.crt /usr/local/share/ca-certificates/burp_cert.crt

# Copiar o certificado do BurpSuite para o container, se ele existir no contexto de construção
COPY burp_cert.crt /usr/local/share/ca-certificates/burp_cert.crt

# Baixando o script de verificação e configuração do certificado
RUN wget https://raw.githubusercontent.com/0xtiago/vps_config/main/docker_check_and_copy_cert.sh \
    -O /usr/local/bin/docker_check_and_copy_cert.sh && \
    chmod +x /usr/local/bin/docker_check_and_copy_cert.sh

# Executando o script de verificação e configuração do certificado
RUN /usr/local/bin/check_and_copy_cert.sh


# Instalando o ohmyzsh e configurando o zsh como bash padrão
# https://ohmyz.sh/#install
RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" && \
    chsh -s /bin/zsh

# Instalando o ohmytmux
RUN git clone https://github.com/gpakosz/.tmux.git /root/.tmux && \
    ln -s -f /root/.tmux/.tmux.conf /root/.tmux.conf && \
    cp /root/.tmux/.tmux.conf.local /root/

# Para manter o container em execução após saídas
CMD ["tail", "-f", "/dev/null"]
