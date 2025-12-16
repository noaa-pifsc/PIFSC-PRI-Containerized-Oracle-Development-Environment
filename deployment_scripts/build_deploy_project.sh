#! /bin/sh

# change to the root repository directory:
cd "$(dirname "$(realpath "$0")")"/..

# load the CDS client functions
source ./modules/pifsc-container-deployment-scripts/src/reusable_functions/shared_functions.sh
source ./modules/pifsc-container-deployment-scripts/src/reusable_functions/client_functions.sh

# load the custom CODE deployment function:
source ./deployment_scripts/functions/custom_deployment_functions.sh

# retrieve the ENV_NAME variable value from the first parameter or by prompting the user
set_env_var "$1" 

echo "Deploy the containerized oracle development environment ($ENV_NAME)"

deploy_dev_environment "$2"

# notify the user that the container has finished executing
echo "The $ENV_NAME docker container has finished building and is running"
