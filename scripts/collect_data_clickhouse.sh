#!/bin/bash
# Collect clickhouse data image

# Bootstrap
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${SCRIPTDIR}/config.sh"
source "${SCRIPTDIR}/helpers.sh"

# Main
download $OTOPS_PROFILE_CLICKHOUSE_DATA_SOURCE $otops_path_clickhouse_source_data_volume