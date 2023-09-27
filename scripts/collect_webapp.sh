#!/bin/bash
# Collect webapp bundle

# Bootstrap
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${SCRIPTDIR}/config.sh"
source "${SCRIPTDIR}/helpers.sh"

# Main
download $OTOPS_PROFILE_WEBAPP_BUNDLE $otops_path_webapp_source_bundle