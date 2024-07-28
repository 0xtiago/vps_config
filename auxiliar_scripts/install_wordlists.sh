#!/bin/bash
WLPATH=$(/opt/wordlists)


if [[ ! -e $WLPATH/kiterunner ]]; then
    mkdir $WLPATH/kiterunner
fi

#Kiterunner
cd $WLPATH/kiterunner
wget https://wordlists-cdn.assetnote.io/rawdata/kiterunner/routes-large.json.tar.gz
tar xvzf routes-large.json.tar.gz
wget https://wordlists-cdn.assetnote.io/rawdata/kiterunner/routes-small.json.tar.gz
tar xvzf routes-small.json.tar.gz

rm -rf routes-large.json.tar.gz
rm -rf routes-small.json.tar.gz