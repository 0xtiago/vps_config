#!/bin/bash

#INICIO DE INSTALACAO DE PRE-REQUISITOS #################################

setupEnvironment() {
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

    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    LOCALPATH=$(pwd)
    TOOLSPATH="/opt/tools"
    WLPATH="/opt/wordlists"

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

    export PATH=$PATH:/usr/local/go/bin
    go version
}
#FIM DE INSTALACAO DE PRE-REQUISITOS #################################

#INICIO DE INSTALAÇÃO DE FERRAMENTAS #################################

Altdns(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    pip3 install py-altdns==1.0.2
}

Alterx(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    go install -v github.com/projectdiscovery/alterx/cmd/alterx@latest
}

Amass(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    snap install amass
}

Anew(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    go install -v github.com/tomnomnom/anew@latest
}

Antiburl(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    cd ${TOOLSPATH} 
    wget https://raw.githubusercontent.com/tomnomnom/hacks/master/anti-burl/main.go
    go build main.go
    rm -rf main.go
    mv main anti-burl ; chmod +x anti-burl
    ln -s $TOOLSPATH/anti-burl /usr/local/bin/anti-burl
}

Arjun(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    pip3 install arjun
}

Assetfinder(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    go install -v github.com/tomnomnom/assetfinder@latest
}

Burl(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    go install -v github.com/tomnomnom/burl@latest
}

ChaosClient(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    GO111MODULE=on go get -v github.com/projectdiscovery/chaos-client/cmd/chaos
}

Collector(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    cd ${TOOLSPATH}
    wget https://raw.githubusercontent.com/m4ll0k/Bug-Bounty-Toolz/master/collector.py
    sed -i '#!/usr/bin/env python3' collector.py
    chmod +x collector.py
    ln -s ${TOOLSPATH}/collector.py /usr/local/bin/collector.py
}

DalFox(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    snap install dalfox
}

Dirsearch(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    cd ${TOOLSPATH}
    git clone https://github.com/maurosoria/dirsearch.git
    cd dirsearch
    pip3 install -r requirements.txt
    chmod +x dirsearch.py
    ln -s ${TOOLSPATH}/dirsearch/dirsearch.py /usr/local/bin/dirsearch
}

Dnsgen(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    pip3 install dnsgen
}

Dnsx(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest
}

DNSValidaor(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    cd ${TOOLSPATH}
    git clone https://github.com/vortexau/dnsvalidator.git
    cd dnsvalidator
    python3 setup.py install
}

ffuf(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    go install -v github.com/ffuf/ffuf@latest
}

Findomains(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    cd /tmp
    wget https://github.com/findomain/findomain/releases/latest/download/findomain-linux.zip
    unzip findomain-linux.zip
    mv findomain /usr/local/bin
    chmod +x /usr/local/bin/findomain
}

Gau(){
    go install -v github.com/lc/gau@latest
}

Gauplus(){
    go install -v  github.com/bp0lr/gauplus@latest
}

Gf(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    cd ${TOOLSPATH}
    git clone https://github.com/tomnomnom/gf.git
    cd gf
    go build main.go
    mv main gf

    mkdir ~/.gf
    cp -r examples/* ~/.gf
    cd /tmp ; git clone https://github.com/1ndianl33t/Gf-Patterns ; cd Gf-Patterns ; cp *.json ~/.gf
}

GithubSearch(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    cd ${TOOLSPATH}
    git clone https://github.com/gwen001/github-search.git
    cd github-search
    pip3 install -r requirements3.txt
    ln -s ${TOOLSPATH}/github-search/github-subdomains.py /usr/local/bin/github-subdomains
}


GitDorker(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    cd ${TOOLSPATH}
    git clone https://github.com/obheda12/GitDorker.git
    cd GitDorker
    pip3 install -r requirements.txt
    chmod +x chmod +x GitDorker.py
    ln -s ${TOOLSPATH}/GitDorker/GitDorker.py /usr/local/bin/gitdorker
}

GitDumper(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    pip install git-dumper
}

GoogleChrome(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    cd /tmp
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    apt install ./google-chrome-stable_current_amd64.deb -y 
}

GoSpider(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    go install -v github.com/jaeles-project/gospider@latest
}

Gowitness(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    local GOWITNESS=https://github.com/sensepost/gowitness/releases/download/2.4.0/gowitness-2.4.0-linux-amd64
    cd $TOOLSPATH ; wget $GOWITNESS
    chmod +x $(basename $GOWITNESS)
    ln -s $TOOLSPATH/$(basename $GOWITNESS) /usr/local/bin/gowitness
}

Hakrawler(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    go install -v github.com/hakluke/hakrawler@latest
}

Hakrevdns(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    go install -v github.com/hakluke/hakrevdns@latest
}

Haktrails(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    go install -v  github.com/hakluke/haktrails@latest
}

Httprobe(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    go install -v github.com/tomnomnom/httprobe@latest
}


Httpx(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
}

JSScanner(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    cd ${TOOLSPATH}
    git clone https://github.com/0x240x23elu/JSScanner.git
    cd JSScanner
    pip3 install -r requirements.txt
    chmod +x JSScanner.py
    ln -s ${TOOLSPATH}/JSScanner/JSScanner.py /usr/local/bin/jsscanner
}

JsubFinder(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    go install github.com/ThreatUnkown/jsubfinder@latest
    wget https://raw.githubusercontent.com/ThreatUnkown/jsubfinder/master/.jsf_signatures.yaml && mv .jsf_signatures.yaml ~/.jsf_signatures.yaml
}

Kiterunner(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    cd ${TOOLSPATH}
    wget https://github.com/assetnote/kiterunner/releases/download/v1.0.2/kiterunner_1.0.2_linux_amd64.tar.gz
    tar xvzf kiterunner_1.0.2_linux_amd64.tar.gz
    chmod +x kr 
    ln -s ${TOOLSPATH}/kr /usr/local/bin/kr
}

LinkFinder(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    cd ${TOOLSPATH}
    git clone https://github.com/GerbenJavado/LinkFinder
    cd LinkFinder
    pip3 install -r requirements.txt
    python3 setup.py install
    ln -s ${TOOLSPATH}/LinkFinder/linkfinder.py /usr/local/bin/linkfinder
}

Mapcidr(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    go install -v  github.com/projectdiscovery/mapcidr/cmd/mapcidr@latest
}

Massdns(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    cd ${TOOLSPATH} 
    git clone https://github.com/blechschmidt/massdns.git
    cd massdns
    make && make nolinux
    ln -s $TOOLSPATH/massdns/bin/massdns /usr/local/bin/massdns
}

MegaPy(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    pip install mega.py
}

Metabigor(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    go install -v  github.com/j3ssie/metabigor@latest
}

Metasploit(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    cd /tmp 
    curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
    chmod 755 msfinstall && ./msfinstall
    msfupdate
}

Naabu(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
}

Notify(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
   go install -v  github.com/projectdiscovery/notify/cmd/notify@latest
}

Nrich(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    local NRICH=https://gitlab.com/api/v4/projects/33695681/packages/generic/nrich/latest/nrich_latest_amd64.deb
    cd /tmp && wget $NRICH
    dpkg -i $(basename $NRICH)
}

Nuclei(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
    ~/go/bin/nuclei -update-templates
}

ParamSpider(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    cd ${TOOLSPATH}
    git clone https://github.com/devanshbatham/ParamSpider
    cd ParamSpider
    pip install .
    ln -s ${TOOLSPATH}/ParamSpider/paramspider.py /usr/local/bin/paramspider
}

PureDNS(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    go install -v github.com/d3mondev/puredns/v2@latest
}



ShufleDNS(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    go install -v  github.com/projectdiscovery/shuffledns/cmd/shuffledns@latest
}

sslscan(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
     apt install sslscan
}



Sub404(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    cd ${TOOLSPATH} 
    git clone https://github.com/r3curs1v3-pr0xy/sub404.git
    cd sub404
    pip3 install -r requirements.txt
    chmod +x sub404.py
    ln -s $TOOLSPATH/sub404/sub404.py /usr/local/bin/sub404
}

Subfinder(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
}

Subjs(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    go install -v  github.com/lc/subjs@latest
}

Telegram-Send(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    pip3 install telegram-send
}

TurboSearch(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    cd ${TOOLSPATH}
    git clone https://github.com/helviojunior/turbosearch.git
    cd turbosearch
    chmod +x turbosearch.py
    ln -s ${TOOLSPATH}/turbosearch/turbosearch.py /usr/local/bin/turbosearch
}

Qsreplace(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    go install -v  github.com/tomnomnom/qsreplace@latest
}

Unfurl(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    go install -v github.com/tomnomnom/unfurl@latest
}

Uro(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    pip3 install uro
}

Katana(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    go install github.com/projectdiscovery/katana/cmd/katana@latest
}

Waybackurls(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    go install -v github.com/tomnomnom/waybackurls@latest
}

WPScan(){
    echo -e "${RED}[+]${FUNCNAME[0]}${NC}"
    gem install wpscan
}

#FIM DE INSTALAÇÃO DE FERRAMENTAS #################################

#INICIO DE CONFIGURACOES FINAIS #################################

PosInstalacao(){
    if [ $USER == 'root' ]; then
        mv /root/go/bin/* /usr/local/bin
    else
        mv /home/$SUDO_USER/go/bin/* /usr/local/bin
    fi
    echo -e "${GREEN}[+] DONE${NC}"

}

#FIM DE CONFIGURACOES FINAIS #################################




callRequirements(){
    setupEnvironment
    setupOSRequirements
    setupGolang
}

callInstallTools(){
    Amass
    Anew
    Antiburl
    Arjun
    Assetfinder
    Burl
    ChaosClient
    Collector
    DalFox
    Dirsearch
    Dnsx
    ffuf
    Findomains
    Gau
    Gauplus
    Gf
    GithubSearch
    GitDorker
    GitDumper
    GoogleChrome
    GoSpider
    Gowitness
    Hakrawler
    Hakrevdns
    Haktrails
    Httprobe
    Httpx
    JSScanner
    Kiterunner
    LinkFinder
    Mapcidr
    Massdns
    MegaPy
    Metabigor
    Metasploit
    Naabu
    Notify
    Nrich
    Nuclei
    ParamSpider
    ShufleDNS
    Sub404
    Subdomains
    Subfinder
    Subjs
    Telegram-Send
    TurboSearch
    Qsreplace
    Unfurl
    Uro
    Katana
    Waybackurls
    WPScan
}


callPosInstalacao(){
    PosInstalacao

}

#Root or Sudoer verifying.
if [[ $(id -u) != 0 ]]; then
    echo -e "\n[!] Script precisa ser executado como sudoer ou root!"
    exit 0
else
    callRequirements
    callInstallTools
    callPosInstalacao
fi
