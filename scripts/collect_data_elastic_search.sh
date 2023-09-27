#!/bin/bash
# Collect Elastic Search data image

# Bootstrap
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${SCRIPTDIR}/config.sh"
source "${SCRIPTDIR}/helpers.sh"

# Main
download $OTOPS_PROFILE_ELASTIC_SEARCH_DATA_SOURCE $otops_path_elastic_search_source_data_volume