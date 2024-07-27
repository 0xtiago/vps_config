#!/bin/sh

CERT_PATH="$(PWD)/burp_cert.crt"

if [ -f "$CERT_PATH" ]; then
    echo "Burp certificate "$CERT_PATH" found. Importing..."
    cp $CERT_PATH /usr/local/share/ca-certificates/burp_cert.crt
    update-ca-certificates
else
    echo "Burp Certificate "$CERT_PATH" not found. Skipping..."
fi
