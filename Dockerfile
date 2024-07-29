FROM ubuntu:latest

RUN apt update && apt install -y \
    zsh \
    git \
    curl \
    wget \
    vim \
    tmux

# Hostname
RUN echo "BaleiaoHacker" > /etc/hostname

# Instalando o ohmyzsh e configurando o zsh como bash padrão
# https://ohmyz.sh/#install
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    chsh -s /bin/zsh

# Configuração para o zsh history
RUN echo 'HISTFILE=/workdir/.zsh_history_docker' >> /root/.zshrc && \
    echo 'HISTSIZE=1000' >> /root/.zshrc && \
    echo 'SAVEHIST=1000' >> /root/.zshrc && \
    echo 'setopt inc_append_history' >> /root/.zshrc && \
    echo 'setopt share_history' >> /root/.zshrc

RUN sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="refined"/' /root/.zshrc

# Instalando o ohmytmux
RUN git clone https://github.com/gpakosz/.tmux.git ~/.tmux && \
    ln -s -f ~/.tmux/.tmux.conf ~/.tmux.conf && \
    cp ~/.tmux/.tmux.conf.local ~/

# Copia o script para o container
COPY auxiliar_scripts/docker_script.sh /usr/local/bin/docker_script.sh

# Define permissões de execução e executa o script
# RUN chmod +x /usr/local/bin/docker_script.sh && \
#     /usr/local/bin/docker_script.sh


#Limpeza de cache para diminuir a imagem
#RUN rm -rf /var/lib/apt/lists/*

WORKDIR /workdir

# Para manter o container em execução após saídas
CMD ["tail", "-f", "/dev/null"]
