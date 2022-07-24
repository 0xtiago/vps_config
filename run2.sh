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
    GODIR=/usr/local
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    #Installing newer GO
    #https://miek.nl/2020/july/17/script-to-upgrade-to-latest-go-version/
    local LATEST=$(curl -s 'https://go.dev/dl/?mode=json' | jq -r '.[0].version')
    local INSTALLED=$(go version | awk '{ print $3 }')
    if [[ ${INSTALLED} == ${LATEST} ]]; then
        echo Go is up to date, running ${LATEST} >&2
        exit 0
    fi
    echo Upgrading Go from ${INSTALLED} to ${LATEST} >&2
    local GOLANG=https://dl.google.com/go/${LATEST}.linux-amd64.tar.gz
    local TAR=$(basename $GOLANG)

    ( cd ${GODIR}
      echo Downloading and extracting: $GOLANG >&2
      wget -q $GOLANG && rm -rf go && tar xvfz ${TAR}
    )

    /usr/local/go/bin/go version
    export PATH=$PATH:/usr/local/go/bin
}


#Root or Sudoer verifying.
if [[ $(id -u) != 0 ]]; then
    echo -e "\n[!] Install.sh need to run as root or sudoer"
    exit 0
else
    callRequirements
fi