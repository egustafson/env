#!/bin/bash

CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
SOURCE_FILE="/etc/apt/sources.list.d/google-cloud-sdk.list"

sudo rm -f ${SOURCE_FILE}
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | \
    sudo tee -a ${SOURCE_FILE}

curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

sudo apt-get update
sudo apt-get install -y google-cloud-sdk

echo -e "\n  google-cloud-sdk installed -- run:  'gcloud init'\n"
