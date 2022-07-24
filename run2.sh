#!/bin/bash

callRequirements(){
    setupEnvironment
    setupOSRequirements
    setupGolang
}

setupEnvironment() {
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    LOCALPATH=$(pwd)
    TOOLSPATH="/opt/tools"
    WLPATH="/opt/wordlists"

    #Cores
    #========================================
    #https://www.shellhacks.com/bash-colors/
    RED='\e[31m'
    GREEN='\e[32m'
    CYAN='\e[36m'
    PURPLE='\e[35m'
    YELLOW='\e[33m'
    NC='\e[0m' # No Color
    #========================================

    #Diretorio de ferramentas
    mkdir /opt/tools

    #Diretorios de wordlists
    mkdir /opt/wordlists

    #Configurando timezone
    timedatectl set-timezone America/Sao_Paulo
}

setupOSRequirements (){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    #Installing packages
    apt-get update 
    apt dist-upgrade -y 
    apt-get install \
    brutespray \
    curl \
    default-jre \
    fonts-powerline \
    git \
    grepcidr \
    gzip \
    htop \
    john \
    jq \
    libpcap-dev \
    locate \
    masscan \
    net-tools \
    nmap \
    p7zip \
    prips \
    python3-pip \
    python-is-python3 \
    ruby-dev \
    snap \
    sqlmap \
    tmux \
    vim \
    zip \
    zsh \
    -y
}

setupGolang () {
    #Installing newer GO
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    apt purge golang -y
    apt autoremove golang -y
    cd /tmp
    wget https://go.dev/dl/go1.18.4.linux-amd64.tar.gz
    rm -rf /usr/local/go && tar -C /usr/local -xzf go1.18.4.linux-amd64.tar.gz
    export PATH=$PATH:/usr/local/go/bin
    #echo "export PATH=$PATH:/usr/local/go/bin:/home/$SUDO_USER/go/bin" >> ~/.bashrc
    #export GOROOT=/usr/local/go
    go version
}


#Root or Sudoer verifying.
if [[ $(id -u) != 0 ]]; then
    echo -e "\n[!] Install.sh need to run as root or sudoer"
    exit 0
else
    callRequirements
fi