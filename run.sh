#!/bin/bash

LOCALPATH=$(pwd)
TOOLSPATH=$(/opt/tools)

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



#=============================================================================================
echo -e "${RED}[+] Installing all requirements${NC}"
#Installing packages
apt-get update && apt-get install net-tools libpcap-dev htop vim gzip zip git python3-pip jq tmux snap grepcidr nmap masscan brutespray prips -y

#Installing newer GO
apt purge golang -y
apt autoremove golang -y
cd /tmp
wget https://golang.org/dl/go1.16.5.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.16.5.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
#echo "export PATH=$PATH:/usr/local/go/bin:/home/$SUDO_USER/go/bin" >> ~/.bashrc
#export GOROOT=/usr/local/go
go version

#Installing anew
go get -u github.com/tomnomnom/anew
#sudo mv ~/go/bin/anew /usr/local/bin

#=============================================================================================
#Install assetfinsder
echo -e "${RED}[+] Installing assetfinder${NC}"
go get -u github.com/tomnomnom/assetfinder
#mv ~/go/bin/assetfinder /usr/local/bin

#Install assetfinder
echo -e "${RED}[+] Installing subfinder${NC}"
GO111MODULE=on go get -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder
#mv ~/go/bin/subfinder /usr/local/bin

#Install amass
echo -e "${RED}[+] Installing amass${NC}"
snap install amass

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
echo -e "${RED}[+] Installing httpx and httprobe ${NC}"
GO111MODULE=on go get -v github.com/projectdiscovery/httpx/cmd/httpx
go get -u github.com/tomnomnom/httprobe

#Install gowitness
echo -e "${RED}[+] Installing gowitness ${NC}"
#go get -v github.com/sensepost/gowitnes
cd $TOOLSPATH ; wget https://github.com/sensepost/gowitness/releases/download/2.3.6/gowitness-2.3.6-linux-amd64
chmod +x gowitness-2.3.6-linux-amd64
ln -s $TOOLSPATH/gowitness-2.3.6-linux-amd64 /usr/local/bin/gowitness


#Install waybackurls
echo -e "${RED}[+] Installing waybackurls, gau and gauplus ${NC}"
go get github.com/tomnomnom/waybackurls
GO111MODULE=on go get -u -v github.com/lc/gau
GO111MODULE=on go get -u -v github.com/bp0lr/gauplus

#Install metabigor and hakrevdns
echo -e "${RED}[+] Installing metabigor and hakrevdns ${NC}"
GO111MODULE=on go get github.com/j3ssie/metabigor
go get github.com/hakluke/hakrevdns

#Install naabu 
echo -e "${RED}[+] Installing naabu ${NC}"
GO111MODULE=on go get -v github.com/projectdiscovery/naabu/v2/cmd/naabu

#Install gf 
echo -e "${RED}[+] Installing and configuring gf ${NC}"
go get -u github.com/tomnomnom/gf
echo 'source $GOPATH/src/github.com/tomnomnom/gf/gf-completion.bash' >> ~/.bashrc
source ~/.bashrc
#Configuring gf patterns
mkdir ~/.gf
cp -r $GOPATH/src/github.com/tomnomnom/gf/examples ~/.gf
cd /tmp ; git clone https://github.com/1ndianl33t/Gf-Patterns ; cd Gf-Patterns ; cp *.json ~/.gf

#Install ParamSpider
echo -e "${RED}[+] Installing paramspider${NC}"
git clone https://github.com/devanshbatham/ParamSpider
cd ParamSpider
pip3 install -r requirements.txt
ln -s /opt/tools/ParamSpider/paramspider.py /usr/local/bin/paramspider

#Install unfurl
echo -e "${RED}[+] Installing unfurl${NC}"
go get -u github.com/tomnomnom/unfurl

#Install ffuf
echo -e "${RED}[+] Installing ffuf${NC}"
go get -u github.com/ffuf/ffuf

#Install arjun
echo -e "${RED}[+] Installing arjun${NC}"
pip3 install arjun


if [ $USER == 'root' ]; then
    mv /root/go/bin/* /usr/local/bin
else
    mv /home/$SUDO_USER/go/bin/* /usr/local/bin
fi

echo -e "${GREEN}[+] DONE${NC}"