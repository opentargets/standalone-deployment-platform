# Standalone local deployment for Open Targets Platform

A standalonce deployment of the [Open Targets Platform](https://platform.opentargets.org/) is useful for platform development and may be useful for customisation of the platform.

Here we have a local orchestration, using docker compose, that can spin up a local instance of the platform with a single command, although some configuration is likely to be desirable.

In order to browse the platform locally, the following components need to be orchestrated together:

1. Open Targets data
   1. OpenSearch data - tar-balled images are publicly available
   2. ClickHouse data - tar-balled images are publicly available 
2. Open Targets software
   1. Web App - bundle is available from [repo](https://github.com/opentargets/ot-ui-apps)
   2. Platform API - publically available as a docker image on [quay.io](https://quay.io/repository/opentargets/platform-api)
   3. OpenAI API - publically available as a docker image on [quay.io](https://quay.io/repository/opentargets/ot-ai-api)
3. 3rd part software
   1. [OpenSearch](https://opensearch.org/)
   2. [ClickHouse](https://clickhouse.com/)
   3. [NGINX](https://www.nginx.com/)

![platfform-components](otar_standalone.png)

## Quickstart

## Requirements
## Running the platform locally
### Configuration
### Commands
### Tips
