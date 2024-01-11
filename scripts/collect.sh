#!/bin/bash
# Collect file

# Bootstrap
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${SCRIPTDIR}/config.sh"

# Functions
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
    gsutil -m cp $source $destination
}

# Args
target=$1
echo $target

# Main
if [[ $target == "webapp" ]]; then
    source=$OTOPS_PROFILE_WEBAPP_BUNDLE
    destination=$otops_path_webapp_source_bundle
elif [[ $target == "clickhouse" ]]; then
    source=$OTOPS_PROFILE_CLICKHOUSE_DATA_SOURCE 
    destination=$otops_path_clickhouse_source_data_volume
elif [[ $target == "elastic" ]]; then
    source=$OTOPS_PROFILE_ELASTIC_SEARCH_DATA_SOURCE 
    destination=$otops_path_elastic_search_source_data_volume
else
    loge "Unknown download target"
    exit 1
fi

# Check if the download exists
if [ -f "$destination" ]; then
    logw "ALREADY EXISTING download at '$destination', SKIPPING download"
    exit 0
fi

download $source $destination
