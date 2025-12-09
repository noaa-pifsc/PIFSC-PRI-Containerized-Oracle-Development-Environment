#! /bin/sh

# change to the directory of the currently running script
cd "$(dirname "$(realpath "$0")")"

# run the prepare docker project script
source ./prepare_docker_project.sh

# change to the root repository directory:
cd "$(dirname "$(realpath "$0")")"/..

pwd

# check if this is a mounted or stack deployment:
if [[ $EXEC_MODE == "mount" ]]; then

	echo "deploy with mounted resources"

# build and execute the docker container for the development scenario
#	docker-compose \
#	--project-directory . \
#	--env-file ./docker/.env \
#	--env-file ./pri_app_docker/.env \
#	-f ./docker/docker-compose-dev.yml \
#	-f ./pri_app_docker/docker-compose.local.dev.yml \
#	up -d  --build

else
	# deploy as a docker stack (TO DO)
	echo "deploy as a docker stack"

fi


# notify the user that the container has finished executing
echo "The dev docker container has finished building and is running"
