#!/bin/bash
# Elastic Search Provisioner

# Bootstrap
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${SCRIPTDIR}/config.sh"


# Main
# Check and wipe existing elastic search data volume
if [ -d "${otops_deployment_path_elastic_search_volume}" ]; then
    logw "WIPING OUT Existing Elastic Search data volume at '${otops_deployment_path_elastic_search_volume}'"
    rm -rf "${otops_deployment_path_elastic_search_volume}/*"
fi

# Check-create elastic search data volume deployment folder
if [ ! -d "${otops_deployment_path_elastic_search_volume}" ]; then
    logi "Creating Elastic Search data volume deployment folder at '${otops_deployment_path_elastic_search_volume}'"
    mkdir -p "${otops_deployment_path_elastic_search_volume}"
fi

# Uncompress elastic search source data volume tarball into elastic search data volume deployment folder
logi "Uncompressing Elastic Search source data volume tarball '${otops_path_elastic_search_source_data_volume}' into Elastic Search data volume deployment folder '${otops_deployment_path_elastic_search_volume}'"
tar -xzf "${otops_path_elastic_search_source_data_volume}" -C "${otops_deployment_path_elastic_search_volume}"
logi "[Elastic Search Provisioner] Done"