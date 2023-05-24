# Global Provisioning Configuration

# Bootstrap
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Environment
# Clickhouse
otops_path_clickhouse_volume="${OTOPS_PATH_DEPLOYMENT}/clickhouse"
otops_path_clickhouse_data="${otops_path_clickhouse_volume}/data"
otops_path_clickhouse_config="${otops_path_clickhouse_volume}/config.d"
otops_path_clickhouse_users="${otops_path_clickhouse_volume}/users.d"
# Elastic Search
otops_path_elastic_search_volume="${OTOPS_PATH_DEPLOYMENT}/elasticsearch"
otops_path_elastic_search_data="${otops_path_elastic_search_volume}/data"
otops_docker_elastic_search_volume="esdata"