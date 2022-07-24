#!/bin/bash

#Root or Sudoer verifying.
if [[ $(id -u) != 0 ]]; then
    echo -e "\n[!] Install.sh need to run as root or sudoer"
    exit 0
else
    callFunctions
fi


callFunctions (){
    setupEnvironment
    setupOSRequirements
    setupGolang
}

setupEnvironment() {
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
    echo -e "${RED}[+] Instalando pre requisitos${NC}"
#Installing packages
apt-get update 
apt dist-upgrade -y 
apt-get install default-jre zsh p7zip curl sqlmap john net-tools \
locate libpcap-dev htop vim gzip ruby-dev zip git python3-pip python-is-python3 \
jq tmux snap grepcidr nmap masscan brutespray prips azure-cli fonts-powerline -y
}

setupGolang () {
    #Installing newer GO
    echo -e "${RED}[+] Intalando Golang${NC}"
    apt purge golang -y
    apt autoremove golang -y
    cd /tmp
    wget https://go.dev/dl/go1.18.4.linux-amd64.tar.gz
    rm -rf /usr/local/go && tar -C /usr/local -xzf go1.16.5.linux-amd64.tar.gz
    export PATH=$PATH:/usr/local/go/bin
    #echo "export PATH=$PATH:/usr/local/go/bin:/home/$SUDO_USER/go/bin" >> ~/.bashrc
    #export GOROOT=/usr/local/go
    go version
}


