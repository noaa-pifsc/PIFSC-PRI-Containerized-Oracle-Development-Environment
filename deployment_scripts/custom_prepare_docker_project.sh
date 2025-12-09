#! /bin/sh

echo "running custom scripts to prepare the docker project"

# load the project configuration script to set the runtime variable values
source ./sh_script_config/custom_project_config.sh

	echo "clone the DSC project's dependencies"

	git clone $dsc_git_url ../tmp/pifsc-dsc

	echo "copy the docker files from the repository to the docker/src subfolder"

	# copy the docker files from the repository to the docker/src subfolder
	cp -r ../tmp/pifsc-dsc/SQL ../docker/src/DSC/SQL
# load the local CODE configuration/secret values
source ../docker/secrets/PRI_local_secrets.sh


	echo "clone the PRI project's dependencies"

#	git clone $pri_git_url ../tmp/pri

	echo "copy the docker files from the repository to the docker/src subfolder"

	# copy the SQL source files from the repository to the docker/src subfolder
	cp -r ../tmp/pri/shared_SQL ../docker/src/PRI/shared_SQL
	cp -r ../tmp/pri/GIM ../docker/src/PRI/GIM
	cp -r ../tmp/pri/RIA ../docker/src/PRI/RIA

	# copy the docker source/configuration files to the pri_app_docker folder
	cp -r ../tmp/pri/docker/* ../pri_app_docker
	
	
	# load the deployment bash scripts from the pri_app_docker directory structure and execute the code/functions to prepare the PRI project
	
		cd ../pri_app_docker/deployment_scripts/client_scripts
		
		# load all function definition files used in local client scripts
		source ./includes/include_local_client_resources.sh

		# initialize the deployment script
		initialize_deployment_script "$0"

		echo "deploy the container locally"

		# define the environment name (these CODE deployments are always intended to be development deployments)
		ENV_NAME="dev" 
		
		# save/prompt for execution mode
#		set_exec_mode_var "$2"
		# hardcode as mount for now:
		EXEC_MODE="mount"

		
		#define the directory paths used to clone the repository and copy the dependencies 
		source_dependency_dir="../../src/backend/dependencies/tmp"
		backend_dependency_dir="../../src/backend/dependencies"
		frontend_dependency_dir="../../src/frontend/res/php-shared-library"

		# load the bash database variables as environment variables:
		export DB_HOST
		export DB_SERVICE_NAME

		# set the APP_INSTANCE environment variable
		export APP_INSTANCE="$ENV_NAME"

		# clone the project dependencies into the current working copy where the script was executed from:
		fetch_git_dependency "$PHP_LIB_GIT_URL" "$source_dependency_dir"

		# copy the required PHP shared library files into the dependencies directory
	#	echo "Copy the backend dependency files (.php and .inc extensions)"
		copy_files_by_filename_expansion "$source_dependency_dir" "$backend_dependency_dir" "*.php" "*.inc"

		# copy the frontend shared library client-side files:
	#	echo "Copy the frontend dependency files (css, js, img directories)"
		copy_asset_directories "$source_dependency_dir" "$frontend_dependency_dir" "css" "js" "img"
		
		# copy the crontab information from the corresponding environment configuration file to make it the active crontab configuration
		cp ../../src/backend/scripts/GIM_crontab.$ENV_NAME.txt ../../src/backend/scripts/GIM_crontab.txt 

		# remove the temporary directory
		rm -rf "$source_dependency_dir"

		# change directory into the docker folder that contains the Dockerfile and .yml files
		cd ../../

		# check if this is a mounted or stack deployment:
		if [[ $EXEC_MODE == "mount" ]]; then
			# this is a mounted directory deployment
			echo "deploy the container with docker compose for development purposes"
			
			# export the variable names defined in the values of the SECRET_MAPPING_ARR array
			export_vars_from_mapping SECRET_MAPPING_ARR
		
		else
			# use docker stack and secrets to test if the code is working for a secure docker host deployment
			echo "deploy the container with docker swarm to test docker secrets"

			# stop the container if it's running so the secrets can be defined/updated
			remove_docker_stack "$DOCKER_STACK_NAME"

			# set the docker secrets for the database information based on the bash variables
			set_db_secrets

			# unset the bash variables used to define the secret values
			unset_config_variables

			# waits for the docker network to be removed
			wait_for_docker_network_removal "$DOCKER_NETWORK_NAME"

		fi		

	echo "The PRI project's dependencies have been added to the docker/src subfolder"


echo "finished executing custom scripts to prepare the docker project"