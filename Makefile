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

export OTOPS_PATH_PROFILES
export OTOPS_PATH_SCRIPTS
export OTOPS_PATH_RELEASE
export OTOPS_PATH_DEPLOYMENT
export OTOPS_ACTIVE_PROFILE
export OTOPS_FLAG_DEPLOYED

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

deploy: release ## [TODO] Deploy an Open Targets Platform Release, according to the active configuration profile
	@echo "[OTOPS] Deploying an Open Targets Platform Release"

teardown: ## [TODO] Tear down an Open Targets Platform deployment
	@echo "[OTOPS] Tearing down an Open Targets Platform deployment"

.PHONY: help set_profile clean_profile summary_environment

