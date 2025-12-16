#!/bin/sh

# function that deploys the containers for dev/test/prod environments
deploy_dev_environment ()
{
	# check the deployment environment:
	if [[ ${ENV_NAME} == "dev" ]]; then

		echo "$ENV_NAME scenario - deploy with mounted resources"

		# dev: build and execute the docker container for the development mounted volume scenario
		docker compose \
		  --env-file ./docker/.env \
		  --env-file ./secrets/.env \
		  -f docker/docker-compose-dev.yml \
		  -f modules/PRI/docker/docker-compose.local.dev.yml \
		  -f docker/docker-compose.integrated.yml \
		  up -d --build --remove-orphans

	else
		# test/prod: deploy without mounted volumes for testing purposes
		echo "$ENV_NAME scenario - deploy without mounted resources"
		
		# build and execute the docker container for the development swarm scenario
		docker compose \
		  --env-file ./docker/.env \
		  --env-file ./secrets/.env \
		  -f docker/docker-compose-test.yml \
		  -f modules/PRI/docker/docker-compose.yml \
		  -f docker/docker-compose.integrated.yml \
		  up -d --build --remove-orphans
		
	fi
}





