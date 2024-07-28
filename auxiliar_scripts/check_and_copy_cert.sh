#!/bin/sh

if [ $# -ne 1 ]; then
    echo "Usage: $0 <path_to_cert>"
    exit 1
fi

CERT_PATH="$1"
CERT_FILE=$(basename "$CERT_PATH")

if [ -f "$CERT_PATH" ]; then
    echo "Certificate $CERT_PATH found. Importing..."
    cp "$CERT_PATH" "/usr/local/share/ca-certificates/$CERT_FILE"
    update-ca-certificates
else
    echo "Certificate $CERT_PATH not found. Skipping..."
fi
