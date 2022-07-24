#!/bin/bash

LOCALPATH=$(pwd)
TOOLSPATH="/opt/tools"
WLPATH="/opt/wordlists"

#COLORS
#========================================
#https://www.shellhacks.com/bash-colors/
RED='\e[31m'
GREEN='\e[32m'
CYAN='\e[36m'
PURPLE='\e[35m'
YELLOW='\e[33m'
NC='\e[0m' # No Color
#========================================


#Root or Sudoer verifying.
if [[ $(id -u) != 0 ]]; then
    echo -e "\n[!] Install.sh need to run as root or sudoer"
    exit 0
fi

#Creating tools directory
mkdir /opt/tools

#Creating wordlists directory
mkdir /opt/wordlists

#Set timezone to Sao Paulo
timedatectl set-timezone America/Sao_Paulo


#=============================================================================================
echo -e "${RED}[+] Installing all requirements${NC}"
#Installing packages
apt-get update 
apt dist-upgrade -y 
apt-get install default-jre zsh p7zip curl sqlmap john net-tools locate libpcap-dev htop vim gzip ruby-dev zip git python3-pip python-is-python3 jq tmux snap grepcidr nmap masscan brutespray prips azure-cli fonts-powerline -y


#Installing newer GO
echo -e "${RED}[+] Installing new version of Golang${NC}"
apt purge golang -y
apt autoremove golang -y
cd /tmp
wget https://go.dev/dl/go1.18.4.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.16.5.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
#echo "export PATH=$PATH:/usr/local/go/bin:/home/$SUDO_USER/go/bin" >> ~/.bashrc
#export GOROOT=/usr/local/go
go version

# Installing RustScan
wget https://github.com/RustScan/RustScan/releases/download/2.0.1/rustscan_2.0.1_amd64.deb -O /tmp/rustscan.deb
dpkg -i /tmp/rustscan.deb


#Installing anew
go get -u github.com/tomnomnom/anew
#sudo mv ~/go/bin/anew /usr/local/bin


#Install notify
echo -e "${RED}[+] Installing notify${NC}"
GO111MODULE=on go get -v github.com/projectdiscovery/notify/cmd/notify



## Install telegram-send
echo -e "${RED}[+] Installing telegram-send${NC}"
pip3 install telegram-send


#Install Subfinder
echo -e "${RED}[+] Installing subfinder${NC}"
GO111MODULE=on go get -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder
#mv ~/go/bin/subfinder /usr/local/bin

#Install amass
echo -e "${RED}[+] Installing amass${NC}"
snap install amass

#Install assetfinder
echo -e "${RED}[+] Installing assetfinder${NC}"
go get -u github.com/tomnomnom/assetfinder
#mv ~/go/bin/assetfinder /usr/local/bin


#Install findomains
echo -e "${RED}[+] Installing findomain${NC}"
cd /tmp
wget https://github.com/findomain/findomain/releases/latest/download/findomain-linux
mv findomain-linux findomain
mv findomain /usr/local/bin
chmod +x /usr/local/bin/findomain

#Install chaos-client
echo -e "${RED}[+] Installing chaos client${NC}"
GO111MODULE=on go get -v github.com/projectdiscovery/chaos-client/cmd/chaos
#mv ~/go/bin/chaos /usr/local/bin

#Install github-search for subdomains
echo -e "${RED}[+] Installing github-search for subdomains${NC}"
cd ${TOOLSPATH}
git clone https://github.com/gwen001/github-search.git
cd github-search
pip3 install -r requirements3.txt
ln -s ${TOOLSPATH}/github-search/github-subdomains.py /usr/local/bin/github-subdomains

#Install hacktrails
echo -e "${RED}[+] Installing hacktrails${NC}"
go get github.com/hakluke/haktrails

#Install httpx
echo -e "${RED}[+] Installing httpx, httprobe, burl and anti-burl ${NC}"
GO111MODULE=on go get -v github.com/projectdiscovery/httpx/cmd/httpx
go get -u github.com/tomnomnom/httprobe
go get github.com/tomnomnom/burl

#Install sub404
echo -e "${RED}[+] Installing sub404 ${NC}"
cd ${TOOLSPATH} 
git clone https://github.com/r3curs1v3-pr0xy/sub404.git
cd sub404
pip3 install -r requirements.txt
chmod +x sub404.py
ln -s $TOOLSPATH/sub404/sub404.py /usr/local/bin/sub404


#Install massdns
echo -e "${RED}[+] Installing massdns ${NC}"
cd ${TOOLSPATH} 
git clone https://github.com/blechschmidt/massdns.git
cd massdns
make && make nolinux
ln -s $TOOLSPATH/massdns/bin/massdns /usr/local/bin/massdns

#Install shuffledns
echo -e "${RED}[+] Installing massdns ${NC}"
GO111MODULE=on go get -v github.com/projectdiscovery/shuffledns/cmd/shuffledns


#AntiBurl
cd ${TOOLSPATH} 
wget https://raw.githubusercontent.com/tomnomnom/hacks/master/anti-burl/main.go
go build main.go
rm -rf main.go
mv main anti-burl ; chmod +x anti-burl
ln -s $TOOLSPATH/anti-burl /usr/local/bin/anti-burl


#Install gowitness
echo -e "${RED}[+] Installing gowitness and Google Chrome${NC}"
#go get -v github.com/sensepost/gowitnes
cd $TOOLSPATH ; wget https://github.com/sensepost/gowitness/releases/download/2.3.6/gowitness-2.3.6-linux-amd64
chmod +x gowitness-2.3.6-linux-amd64
ln -s $TOOLSPATH/gowitness-2.3.6-linux-amd64 /usr/local/bin/gowitness
# Install google chrome
cd /tmp
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt install ./google-chrome-stable_current_amd64.deb -y 


#Install waybackurls
echo -e "${RED}[+] Installing waybackurls, gau and gauplus ${NC}"
go get github.com/tomnomnom/waybackurls
GO111MODULE=on go get -u -v github.com/lc/gau
GO111MODULE=on go get -u -v github.com/bp0lr/gauplus

#Install metabigor and hakrevdns
echo -e "${RED}[+] Installing metabigor and hakrevdns ${NC}"
GO111MODULE=on go get github.com/j3ssie/metabigor
go get github.com/hakluke/hakrevdns

#Install dnsx
echo -e "${RED}[+] Installing dnsx ${NC}"
GO111MODULE=on go get -v github.com/projectdiscovery/dnsx/cmd/dnsx

#Install mapcidr
echo -e "${RED}[+] Installing mapcidr ${NC}"
GO111MODULE=on go get -v github.com/projectdiscovery/mapcidr/cmd/mapcidr

#Install naabu 
echo -e "${RED}[+] Installing naabu ${NC}"
GO111MODULE=on go get -v github.com/projectdiscovery/naabu/v2/cmd/naabu

#Install gf 
echo -e "${RED}[+] Installing and configuring gf ${NC}"
cd ${TOOLSPATH}
git clone https://github.com/tomnomnom/gf.git
cd gf
go build main.go
mv main gf

#Configuring gf patterns
mkdir ~/.gf
cp -r examples/* ~/.gf
cd /tmp ; git clone https://github.com/1ndianl33t/Gf-Patterns ; cd Gf-Patterns ; cp *.json ~/.gf

#Install ParamSpider
echo -e "${RED}[+] Installing paramspider${NC}"
cd ${TOOLSPATH}
git clone https://github.com/devanshbatham/ParamSpider
cd ParamSpider
pip3 install -r requirements.txt
ln -s ${TOOLSPATH}/ParamSpider/paramspider.py /usr/local/bin/paramspider

#Install Linkfinder and Collector
#Linkfinder
echo -e "${RED}[+] Installing LinkFinder and collector ${NC}"
cd ${TOOLSPATH}
git clone https://github.com/GerbenJavado/LinkFinder
cd LinkFinder
pip3 install -r requirements.txt
python3 setup.py install
ln -s ${TOOLSPATH}/LinkFinder/linkfinder.py /usr/local/bin/linkfinder
#Collector
cd ${TOOLSPATH}
wget https://raw.githubusercontent.com/m4ll0k/Bug-Bounty-Toolz/master/collector.py
sed -i '#!/usr/bin/env python3' collector.py
chmod +x collector.py
ln -s ${TOOLSPATH}/collector.py /usr/local/bin/collector.py

#Install Hakrawler
echo -e "${RED}[+] Installing Hakcrawler${NC}"
go get github.com/hakluke/hakrawler

#Install GoSpider
echo -e "${RED}[+] Installing GoSpider${NC}"
GO111MODULE=on go get -u github.com/jaeles-project/gospider

#Install GoSpider
echo -e "${RED}[+] Installing qsreplace${NC}"
go get -u github.com/tomnomnom/qsreplace


#Install unfurl
echo -e "${RED}[+] Installing unfurl${NC}"
go get -u github.com/tomnomnom/unfurl


#Install arjun
echo -e "${RED}[+] Installing arjun${NC}"
pip3 install arjun

#Install subjs
echo -e "${RED}[+] Installing subjs${NC}"
GO111MODULE=on go get -u -v github.com/lc/subjs


#Install ffuf
echo -e "${RED}[+] Installing ffuf${NC}"
go get -u github.com/ffuf/ffuf

#Install kiterunner
echo -e "${RED}[+] Installing KiteRunner${NC}"
cd ${TOOLSPATH}
wget https://github.com/assetnote/kiterunner/releases/download/v1.0.2/kiterunner_1.0.2_linux_amd64.tar.gz
tar xvzf kiterunner_1.0.2_linux_amd64.tar.gz
chmod +x kr 
ln -s ${TOOLSPATH}/kr /usr/local/bin/kr

#Install dirsearch
echo -e "${RED}[+] Installing Dirsearch${NC}"
cd ${TOOLSPATH}
git clone https://github.com/maurosoria/dirsearch.git
cd dirsearch
pip3 install -r requirements.txt
chmod +x dirsearch.py
ln -s ${TOOLSPATH}/dirsearch/dirsearch.py /usr/local/bin/dirsearch

#Install TurboSearch
echo -e "${RED}[+] Installing TurboSearch${NC}"
cd ${TOOLSPATH}
git clone https://github.com/helviojunior/turbosearch.git
cd turbosearch
chmod +x turbosearch.py
ln -s ${TOOLSPATH}/turbosearch/turbosearch.py /usr/local/bin/turbosearch

#Install Git-Dorker
echo -e "${RED}[+] Installing GitDorker${NC}"
cd ${TOOLSPATH}
git clone https://github.com/obheda12/GitDorker.git
cd GitDorker
pip3 install -r requirements.txt
chmod +x chmod +x GitDorker.py
ln -s ${TOOLSPATH}/GitDorker/GitDorker.py /usr/local/bin/gitdorker

#Install Git-dumper
echo -e "${RED}[+] Installing Git-dumper${NC}"
pip install git-dumper

# Install nuclei
echo -e "${RED}[+] Installing nuclei${NC}"
go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
~/go/bin/nuclei -update-templates

# Install nrich
cd /tmp && wget https://gitlab.com/api/v4/projects/33695681/packages/generic/nrich/latest/nrich_latest_amd64.deb
dpkg -i nrich_latest_amd64.deb

# Install dalfox
echo -e "${RED}[+] Installing DalFox${NC}"
snap install dalfox

#Install JsScanner
echo -e "${RED}[+] Installing JsScanner${NC}"
cd ${TOOLSPATH}
git clone https://github.com/0x240x23elu/JSScanner.git
cd JSScanner
pip3 install -r requirements.txt
chmod +x JSScanner.py
ln -s ${TOOLSPATH}/JSScanner/JSScanner.py /usr/local/bin/jsscanner


# Install wpscan
echo -e "${RED}[+] Installing WPScan${NC}"
 gem install wpscan

# Install URO
echo -e "${RED}[+] Installing URO${NC}"
 pip3 install uro

## Install Metasploit
echo -e "${RED}[+] Installing Metasploit${NC}"
cd /tmp 
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
chmod 755 msfinstall && ./msfinstall
# update - Need only for later usage
msfupdate

#Install Axiom
#echo -e "${RED}[+] Installing Axiom${NC}"
#cd /tmp
#bash <(curl -s https://raw.githubusercontent.com/pry0cc/axiom/master/interact/axiom-configure)


if [ $USER == 'root' ]; then
    mv /root/go/bin/* /usr/local/bin
else
    mv /home/$SUDO_USER/go/bin/* /usr/local/bin
fi

echo -e "${GREEN}[+] DONE${NC}"


#echo -e "${RED}[+] Installing all new bash environment, ohmyzsh and tmux config ${NC}"
#Add my tmux profile
cd ~ && https://raw.githubusercontent.com/0xtiago/dotfiles/master/tmux/.tmux.conf
## Install ohmyzsh
#sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#change zshrc theme
#sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="gentoo"/g' ~/.zshrc
#Add golang bin dir to $PATH.
#echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.zshrc

#TMux configuration
#echo "#Run TMUX automatically" >> ~/.zshrc
#cat <<EOF >> ~/.zshrc
#if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
#    tmux attach -t default || tmux new -s default
#fi
#EOF


#source ~/.zshrc
