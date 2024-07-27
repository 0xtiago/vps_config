#!/bin/sh

CERT_PATH="burp_cert.crt"

if [ -f "$CERT_PATH" ]; then
    echo "Burp certificate "$CERT_PATH" found. Importing..."
    update-ca-certificates
else
    echo "Burp Certificate "$CERT_PATH" not found. Skipping..."
fi
