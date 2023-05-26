# This Makefile helper automates bringing up and tearing down a local deployment of Open Targets Platform
.DEFAULT_GOAL := help

# Environment variables
ROOT_DIR_MAKEFILE:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
OTOPS_PATH_PROFILES:=$(ROOT_DIR_MAKEFILE)/profiles
OTOPS_PATH_SCRIPTS:=$(ROOT_DIR_MAKEFILE)/scripts
OTOPS_PATH_RELEASE:=$(ROOT_DIR_MAKEFILE)/release
OTOPS_PATH_DEPLOYMENT:=$(ROOT_DIR_MAKEFILE)/deployment
OTOPS_ACTIVE_PROFILE:=config_profile.sh
OTOPS_FLAG_DEPLOYED:=.deployed
OTOPS_PROVISIONER_CLICKHOUSE:=$(OTOPS_PATH_SCRIPTS)/provisioner_clickhouse.sh
OTOPS_PROVISIONER_ELASTIC_SEARCH:=$(OTOPS_PATH_SCRIPTS)/provisioner_elastic_search.sh
OTOPS_PROVISIONER_WEBAPP:=$(OTOPS_PATH_SCRIPTS)/provisioner_webapp.sh

export OTOPS_PATH_PROFILES
export OTOPS_PATH_SCRIPTS
export OTOPS_PATH_RELEASE
export OTOPS_PATH_DEPLOYMENT
export OTOPS_ACTIVE_PROFILE
export OTOPS_FLAG_DEPLOYED
export OTOPS_PROVISIONER_CLICKHOUSE
export OTOPS_PROVISIONER_ELASTIC_SEARCH
export OTOPS_PROVISIONER_WEBAPP

include .env

# Targets
help: ## Show this help message
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make <target>\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  %-15s %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

set_profile: ## Set an active configuration profile, e.g. "make set_profile profile='dev'" (see folder 'profiles')
	@echo "[OTOPS] Setting active profile '${profile}'"
	@ln -sf profiles/config.${profile} ${OTOPS_ACTIVE_PROFILE}

clean_profile: ## Clean the active configuration profile
	@echo "[OTOPS] Cleaning active profile"
	@rm -f ${OTOPS_ACTIVE_PROFILE}

.env: env.sh ${OTOPS_ACTIVE_PROFILE} ## Create a .env file from the active configuration profile
	@echo "[OTOPS] Creating .env file from active profile"
	@bash -c 'source ${OTOPS_ACTIVE_PROFILE} && ./env.sh' > .env

summary_environment: .env ## Print a summary of the configuration environment
	@echo "[OTOPS] Summary of the configuration environment"
	@env | grep -E '^(OTOPS_)' | sort

release: ## [TODO] Collect all the artifacts that make up an Open Targets Platform Release, according to the active configuration profile
	@echo "[OTOPS] Collecting all the artifacts that make up an Open Targets Platform Release"

deployment: ## Create a deployment folder where Open Targets Platform provisioners will deposit their artifacts
	@echo "[OTOPS] Creating deployment folder at '${OTOPS_PATH_DEPLOYMENT}'"
	@mkdir -p ${OTOPS_PATH_DEPLOYMENT}

deploy_clickhouse: deployment ## Deploy ClickHouse
	@echo "[OTOPS] Provisioning Clickhouse data store"
	@cd $(shell dirname ${OTOPS_PROVISIONER_CLICKHOUSE}) && ./$(shell basename ${OTOPS_PROVISIONER_CLICKHOUSE})

deploy_elastic_search: deployment ## Deploy Elastic Search
	@echo "[OTOPS] Provisioning Elastic Search data store"
	@cd $(shell dirname ${OTOPS_PROVISIONER_ELASTIC_SEARCH}) && ./$(shell basename ${OTOPS_PROVISIONER_ELASTIC_SEARCH})

deploy: release deployment ## [TODO] Deploy an Open Targets Platform Release, according to the active configuration profile
	@echo "[OTOPS] Deploying an Open Targets Platform Release"

teardown: ## [TODO] Tear down an Open Targets Platform deployment
	@echo "[OTOPS] Tearing down an Open Targets Platform deployment"

.PHONY: help set_profile clean_profile summary_environment deploy_clickhouse deploy_elastic_search deploy release teardown

