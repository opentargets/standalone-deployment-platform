#!/bin/bash
# Collect file

# Bootstrap
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${SCRIPTDIR}/config.sh"

# Functions
function remove () {
    local file="${1}"
    logi "Removing $file"
    rm $file
}

# Args
target=$1
echo $target

# Main
if [[ $target == "webapp" ]]; then
    file=$otops_path_webapp_source_bundle
elif [[ $target == "clickhouse" ]]; then
    file=$otops_path_clickhouse_source_data_volume
elif [[ $target == "elastic" ]]; then
    file=$otops_path_elastic_search_source_data_volume
else
    loge "Unknown target"
    exit 1
fi

# Check if the download exists
if [ ! -f "$file" ]; then
    logw "No file at '$file', SKIPPING clean"
    exit 0
fi

remove $file