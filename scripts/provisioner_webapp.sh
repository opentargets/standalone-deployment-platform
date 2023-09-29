#!/bin/bash
# Web App Provisioner

# Bootstrap
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${SCRIPTDIR}/config.sh"

# Environment
# Some notes for the download of the webapp release artifact:
# Sample release artifact URL: https://github.com/opentargets/ot-ui-apps/releases/download/v0.3.9/bundle-platform.tgz
#otops_provisioner_webapp_github_url="https://github.com/opentargets/ot-ui-apps"
#otops_provisioner_webapp_github_release_url_base="${otops_provisioner_webapp_github_url}/releases/download"
#otops_provisioner_webapp_github_release_artifact="bundle-platform.tgz"
#otops_provisioner_webapp_github_release_url="${otops_provisioner_webapp_github_release_url_base}/v${otops_provisioner_webapp_version}/${otops_provisioner_webapp_github_release_artifact}"
otops_provisioner_webapp_path_static_data_context="${otops_deployment_path_webapp_root}/data"
otops_provisioner_webapp_path_devops_context="${otops_deployment_path_webapp_root}/config.js"
otops_provisioner_webapp_path_devops_context_template="${otops_deployment_path_webapp_root}/config.template"
# Web Application DevOps Context - THIS SHOULD BE INJECTED FROM THE ENVIRONMENT, because it contains information that depends on the 'docker-compose' file
export DEVOPS_CONTEXT_PLATFORM_APP_CONFIG_URL_API="'http:\/\/localhost:8090\/api\/v4\/graphql'"
export DEVOPS_CONTEXT_PLATFORM_APP_CONFIG_URL_API_BETA="'http:\/\/localhost:8090\/api\/v4\/graphql'"
export DEVOPS_CONTEXT_PLATFORM_APP_CONFIG_EFO_URL="'\/data\/ontology\/efo_json\/diseases_efo.jsonl'"
export DEVOPS_CONTEXT_PLATFORM_APP_CONFIG_GOOGLE_TAG_MANAGER_ID="'GTM-WPXWRDV'"
export DEVOPS_CONTEXT_PLATFORM_APP_CONFIG_OT_AI_API_URL="'http:\/\/localhost:8081'"


# Main
logi "Provisioning Web App"
# Check if the webapp deployment folder exists
if [ -d "${otops_deployment_path_webapp_root}" ]; then
    logw "ALREADY EXISTING Web App deployment at '${otops_deployment_path_webapp_root}', SKIP PROVISIONING"
    exit 0
fi

# Check create webapp deployment folder
if [ ! -d "${otops_deployment_path_webapp_root}" ]; then
    logi "Creating Web App deployment folder at '${otops_deployment_path_webapp_root}'"
    mkdir -p "${otops_deployment_path_webapp_root}"
fi

# Check create webapp static context folder
if [ ! -d "${otops_provisioner_webapp_path_static_data_context}" ]; then
    logi "Creating Web App static context folder at '${otops_provisioner_webapp_path_static_data_context}'"
    mkdir -p "${otops_provisioner_webapp_path_static_data_context}"
fi

# Uncompress the webapp release artifact into the webapp deployment folder
logi "Uncompressing Web App release artifact '${otops_path_webapp_source_bundle}' into Web App deployment folder '${otops_deployment_path_webapp_root}'"
tar -xzf "${otops_path_webapp_source_bundle}" -C "${otops_deployment_path_webapp_root}"
# Attach the web app static context under 'data' folder in the web app deployment folder
logi "Attaching Web App static context under 'data' folder in the Web App deployment folder '${otops_deployment_path_webapp_root}'"
cp -r "${otops_deployment_path_webapp_static_data_context}/*" "${otops_provisioner_webapp_path_static_data_context}"
# TODO Environment configuration injection
# Copy the devops context template into the devops context
logi "Copying Web App devops context template '${otops_provisioner_webapp_path_devops_context_template}' into Web App devops context '${otops_provisioner_webapp_path_devops_context}'"
cp "${otops_provisioner_webapp_path_devops_context_template}" "${otops_provisioner_webapp_path_devops_context}"
for envvar in $(cat ${otops_provisioner_webapp_path_devops_context} | egrep -o "DEVOPS[_A-Z]+$"); do
    export key=${envvar}
    export value=${!envvar:-undefined}
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo -e "\t[CONTEXT] Injecting '${key}=${value}'"
        sed -r -i "s/${key}(\W|$)/${value};/g" ${otops_provisioner_webapp_path_devops_context}
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo -e "\t[CONTEXT] Injecting '${key}=${value}'"
        sed -E -i ".bak" "s/${key}(\W|$)/${value};/g" ${otops_provisioner_webapp_path_devops_context}
    else
        echo "Unsupported OS: please use Mac or Linux"
    fi
done
logi "[Web App Provisioner] Done"