#!/bin/bash

# Helpers
function download() {
    local source="${1}" # URL (http/ftp/gs supported)
    local destination="${2}" # local file path
    logi "Attempting to download $source --> $destination"
    if [[ -z $source || -z $destination ]]; then
        loge "Download not possible because source or destination are not set"
    elif [[ "$source" =~ ^http.*|^ftp.* ]]; then
        download_with_http $source $destination
    elif [[ "$source" =~ ^gs.* ]]; then
        download_with_gsutil $source $destination
    else
        loge "Unable to identify protocol when retrieving data"
    fi
}

# HTTP/FTP Downloader
function download_with_http() {
    logi "Using HTTP"
    local source="${1}"
    local destination="${2}" 
    wget -O $destination $source
}

# Google bucket Downloader
function download_with_gsutil() {
    logi "Using gsutil"
    local source="${1}"
    local destination="${2}"
    gsutil cp $source $destination
}