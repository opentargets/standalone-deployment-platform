#!/bin/bash
# Clickhouse Provisioner

# Bootstrap
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${SCRIPTDIR}/config.sh"

# Main
logi "Provisioning Clickhouse"
# Check if the clickhouse data volume exists
if [ -d "${otops_deployment_path_clickhouse_volume}" ]; then
    logw "ALREADY EXISTING Clickhouse deployment at '${otops_deployment_path_clickhouse_volume}', SKIP PROVISIONING"
    exit 0
fi

# Check create clickhouse data volume deployment folder
if [ ! -d "${otops_deployment_path_clickhouse_volume}" ]; then
    logi "Creating Clickhouse data volume deployment folder at '${otops_deployment_path_clickhouse_volume}'"
    mkdir -p "${otops_deployment_path_clickhouse_volume}"
fi

# Uncompress clickhouse source data volume tarball into clickhouse data volume deployment folder
logi "Uncompressing Clickhouse source data volume tarball '${otops_path_clickhouse_source_data_volume}' into Clickhouse data volume deployment folder '${otops_deployment_path_clickhouse_volume}'"
tar -xzf "${otops_path_clickhouse_source_data_volume}" -C "${otops_deployment_path_clickhouse_volume}"
logi "[Clickhouse Provisioner] Done"