#!/bin/bash
# Global Provisioning Configuration

# Bootstrap
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Environment
# Clickhouse
export otops_path_clickhouse_source_data_volume="${OTOPS_PATH_RELEASE}/clickhouse.tgz"
export otops_deployment_path_clickhouse_volume="${OTOPS_PATH_DEPLOYMENT_CLICKHOUSE}"
export otops_deployment_path_clickhouse_data="${otops_path_clickhouse_volume}/data"
export otops_deployment_path_clickhouse_config="${otops_path_clickhouse_volume}/config.d"
export otops_deployment_path_clickhouse_users="${otops_path_clickhouse_volume}/users.d"
# Elastic Search
export otops_path_elastic_search_source_data_volume="${OTOPS_PATH_RELEASE}/elastic_search.tgz"
export otops_deployment_path_elastic_search_volume="${OTOPS_PATH_DEPLOYMENT_ELASTIC_SEARCH}"
export otops_deployment_path_elastic_search_data="${otops_path_elastic_search_volume}/data"
export otops_docker_elastic_search_volume="esdata"
# Web App
export otops_path_webapp_source_bundle="${OTOPS_PATH_RELEASE}/webapp.tgz"
export otops_path_webapp_source_static_data_context="${OTOPS_PATH_RELEASE}/webapp_static_context"
export otops_deployment_path_webapp_root="${OTOPS_PATH_DEPLOYMENT_WEBAPP}"

# Helper functions
# Logging function with log levels
function otops_log() {
    local level=$1
    shift
    local message=$@
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo -e "${timestamp} [${level}] ${message}"
}

function logi() {
    otops_log "INFO" $@
}

function logw() {
    otops_log "WARN" $@
}

function loge() {
    otops_log "ERROR" $@
}

# Print a summary of the environment variables starting with 'OTOPS' or 'otops'
otops_print_env() {
    logi "Common Configuration Environment Variables:"
    env | grep ^OTOPS | sort
}



# Main
# Print the environment variables starting with 'OTOPS' or 'otops'
otops_print_env