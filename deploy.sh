#!/bin/bash

function deploy_senzing () {
	printf "Deploying Senzing ..."
	#docker run --rm -it -e SENZING_ENGINE_CONFIGURATION_JSON senzing/init-postgresql mandatory
	docker run --rm -d -e SENZING_ENGINE_CONFIGURATION_JSON senzing/init-postgresql mandatory
}

function deploy_senzing_tools () {
	printf "Deploy senzing tool container ...\n"
        docker run --rm -d -e SENZING_ENGINE_CONFIGURATION_JSON senzing/senzingapi-tools
}

function deploy_senzing_webapp () {
        printf "Deploy senzing web tool ui container ....\n"
	source ./config.sh
        docker run -d \
		--rm \
		-p 8251:8251 \
		--platform linux/x86_64 \
		-e SENZING_ENGINE_CONFIGURATION_JSON senzing/web-app-demo
}

#This initialises the database
deploy_senzing

#This deploys a container with senzing tools
#deploy_senzing_tools

#This deploys a sample web app
deploy_senzing_webapp
