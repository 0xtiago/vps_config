FROM ubuntu:latest

ENV HOSTNAME=Baleiao

RUN apt update && apt install -y \
    zsh \
    git \
    curl \
    wget \
    golang \
    python3 \
    python3-pip


WORKDIR /workdir


# Instalando o ohmyzsh e configurando o zsh como bash padrão
# https://ohmyz.sh/#install
RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" && \
    chsh -s /bin/zsh

# Spaceship
RUN git clone https://github.com/denysdovhan/spaceship-prompt.git "/root/.oh-my-zsh/custom/themes/spaceship-prompt" && \
    ln -s "/root/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme" "/root/.oh-my-zsh/custom/themes/spaceship.zsh-theme"

# Configuração para o zsh history e Spaceship
RUN echo 'ZSH_THEME="spaceship"' >> /root/.zshrc && \
    echo 'HISTFILE=/workdir/.zsh_history_docker' >> /root/.zshrc && \
    echo 'HISTSIZE=1000' >> /root/.zshrc && \
    echo 'SAVEHIST=1000' >> /root/.zshrc && \
    echo 'setopt inc_append_history' >> /root/.zshrc && \
    echo 'setopt share_history' >> /root/.zshrc && \
    echo 'SPACESHIP_PROMPT_ORDER=("user" "dir" "git" "host" "exec_time" "line_sep" "jobs" "exit_code" "char")' >> /root/.zshrc && \
    echo 'SPACESHIP_DIR_TRUNC=0' >> /root/.zshrc && \
    echo 'SPACESHIP_DIR_PREFIX="🐳 "' >> /root/.zshrc && \
    echo 'SPACESHIP_CHAR_SYMBOL="➜ "' >> /root/.zshrc && \
    echo 'SPACESHIP_CHAR_SUFFIX=""' >> /root/.zshrc

# Cria .zsh_history
# Vc precisa criar o .zsh_history localmente para o mapeamento!
# $ touch .zsh_history
# RUN touch /root/.zsh_history

# Executa script básico de instalação de configuração do container
RUN wget -O - "https://raw.githubusercontent.com/0xtiago/vps_config/main/run_basic.sh" | bash



# Instalando o ohmytmux
RUN git clone https://github.com/gpakosz/.tmux.git /root/.tmux && \
    ln -s -f /root/.tmux/.tmux.conf /root/.tmux.conf && \
    cp /root/.tmux/.tmux.conf.local /root/


# Para manter o container em execução após saídas
CMD ["tail", "-f", "/dev/null"]
