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

# Main
logi "Provisioning Web App"
# Check if the webapp deployment folder exists
if [ -d "${otops_deployment_path_webapp_root}" ]; then
    logw "WIPING OUT Existing Web App deployment folder at '${otops_deployment_path_webapp_root}'"
    rm -rf "${otops_deployment_path_webapp_root}/*"
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
logi "Attaching Web App static context under 'data' folder in the Web App deployment folder '${otops_deployment_path_webapp}'"
cp -r "${otops_deployment_path_webapp_static_data_context}/*" "${otops_provisioner_webapp_path_static_data_context}"
logi "[Web App Provisioner] Done"