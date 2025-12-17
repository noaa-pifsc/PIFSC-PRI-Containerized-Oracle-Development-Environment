# PIFSC PRI Oracle Developer Environment

## Overview
The PIFSC Resource Inventory (PRI) Oracle Developer Environment (PCODE) project was developed to provide a custom containerized Oracle development environment (CODE) for the DSC.  This repository can be forked to extend the existing functionality to any data systems that depend on the DSC for both development and testing purposes.  

## Resources
-   ### PCODE Version Control Information
    -   URL: https://github.com/noaa-pifsc/PIFSC-PRI-Containerized-Oracle-Development-Environment
    -   Version: 1.0 (git tag: PRI_CODE_v1.0)
    -   Upstream repository:
        -   DCODE Version Control Information:
            -   URL: https://github.com/noaa-pifsc/PIFSC-DSC-Containerized-Oracle-Development-Environment
            -   Version: 1.2 (git tag: DCODE_v1.2)

## Dependencies
\* Note: all dependencies are implemented as git submodules in the [modules](./modules) folder
-   ### PRI Version Control Information
    -   Version Control Information:
        -   URL: <https://picgitlab.nmfs.local/centralized-data-tools/pifsc-resource-inventory.git>
        -   Application: 1.8 (Git tag: PRI_docker_app_v1.8)
-   ### DSC Version Control Information
    -   Version Control Information:
        -   URL: <git@picgitlab.nmfs.local:centralized-data-tools/pifsc-dsc.git>
        -   Database: 1.1 (Git tag: dsc_db_v1.1)
-   ### Container Deployment Scripts (CDS) Version Control Information
    -   Version Control Information:
        -   URL: <git@picgitlab.nmfs.local:centralized-data-tools/pifsc-container-deployment-scripts.git>
        -   Database: 1.1 (Git tag: pifsc_container_deployment_scripts_v1.1)

## Prerequisites
-   See the CODE [Prerequisites](https://github.com/noaa-pifsc/PIFSC-Containerized-Oracle-Development-Environment?tab=readme-ov-file#prerequisites) for details

## Repository Fork Diagram
-   See the CODE [Repository Fork Diagram](https://github.com/noaa-pifsc/PIFSC-Containerized-Oracle-Development-Environment?tab=readme-ov-file#repository-fork-diagram) for details

## Runtime Scenarios
-   See the CODE [Runtime Scenarios](https://github.com/noaa-pifsc/PIFSC-Containerized-Oracle-Development-Environment?tab=readme-ov-file#runtime-scenarios) for details

## Automated Deployment Process
-   ### Prepare the project
    -   Recursively clone the [PCODE repository](#pcode-version-control-information) to a working directory
    -   (optional) Update the [.env](./secrets/.env) custom environment variables accordingly for the PRI app
    -   Create the git_key.txt in the [secrets](./secrets) folder with a git API key to authenticate requests to the git API. 
        -   [git_key.template.txt](./secrets/git_key.template.txt) is a template available that can be renamed to define the secret
-   ### Build and Run the Containers 
    -   See the CODE [Build and Run the Containers](https://github.com/noaa-pifsc/PIFSC-Containerized-Oracle-Development-Environment?tab=readme-ov-file#build-and-run-the-containers) for details
    -   #### DSC Database Deployment
        -   [create_docker_schemas.sql](https://picgitlab.nmfs.local/centralized-data-tools/pifsc-dsc/-/blob/main/SQL/dev_container_setup/create_docker_schemas.sql?ref_type=heads) is executed by the SYS schema to create the DSC schema and grant the necessary privileges
        -   [deploy_dev_container.sql](https://picgitlab.nmfs.local/centralized-data-tools/pifsc-dsc/-/blob/main/SQL/automated_deployments/deploy_dev_container.sql?ref_type=heads) is executed with the DSC schema to deploy the objects to the DSC schema
    -   #### PRI Database Deployment
        -   [create_docker_schemas.sql](https://picgitlab.nmfs.local/centralized-data-tools/pifsc-resource-inventory/-/blob/master/shared_SQL/dev_container_setup/create_docker_schemas.sql?ref_type=heads) is executed by the SYS schema to create the PRI schema and grant the necessary privileges
        -   [deploy_dev.sql](https://picgitlab.nmfs.local/centralized-data-tools/pifsc-resource-inventory/-/blob/master/shared_SQL/automated_deployments/deploy_dev.sql?ref_type=heads) is executed with the PRI schema to deploy the objects to the PRI schema
        -   [deploy_RIA_dev.sql](https://picgitlab.nmfs.local/centralized-data-tools/pifsc-resource-inventory/-/blob/master/shared_SQL/automated_deployments/deploy_RIA_dev.sql?ref_type=heads) is executed with the PRI_RIA_APP schema to deploy the objects to the PRI_RIA_APP schema
        -   [deploy_GIM_dev.sql](https://picgitlab.nmfs.local/centralized-data-tools/pifsc-resource-inventory/-/blob/master/shared_SQL/automated_deployments/deploy_GIM_dev.sql?ref_type=heads) is executed with the PRI_GIM_APP schema to deploy the objects to the PRI_GIM_APP schema

## Customization Process
-   ### Implementation
    -   \*Note: this process will fork the PCODE parent repository and repurpose it as a project-specific CODE
    -   Fork [this repository](#pcode-version-control-information)
    -   See the CODE [Implementation](https://github.com/noaa-pifsc/PIFSC-Containerized-Oracle-Development-Environment?tab=readme-ov-file#implementation) for details 
-   ### Upstream Updates
    -   See the CODE [Upstream Updates](https://github.com/noaa-pifsc/PIFSC-Containerized-Oracle-Development-Environment?tab=readme-ov-file#upstream-updates) for details

## Container Architecture
-   See the CODE [container architecture documentation](https://github.com/noaa-pifsc/PIFSC-Containerized-Oracle-Development-Environment?tab=readme-ov-file/-/blob/main/README.md?ref_type=heads#container-architecture) for details
-   ### PCODE Customizations:
    -   [docker/.env](./docker/.env) was updated to define an appropriate APP_SCHEMA_NAME value
    -   [custom_deployment_functions.sh](./deployment_scripts/functions/custom_deployment_functions.sh) was updated to add the PRI docker-compose.yml file and the [secrets/.env](./secrets/.env) file.  It was also updated to remove the [CODE-ords.yml](./docker/CODE-ords.yml) configuration file
    -   [custom-docker-compose.yml](./docker/custom-docker-compose.yml) was updated to implement file-based secrets, PRI and CODE-specific mounted volume overrides 
    -   [custom_db_app_deploy.sh](./docker/src/deployment_scripts/custom_db_app_deploy.sh) was updated to deploy the PRI database and application schemas
    -   [custom_container_config.sh](./docker/src/deployment_scripts/config/custom_container_config.sh) was updated to define DB credentials and mounted volume file paths for the PRI SQL scripts
    -   Multiple files were added in the [secrets](./secrets) folder to specify secret values (e.g. [ria_pass.txt](./secrets/ria_pass.txt) to specify the RIA database password)
        -   [secrets/.env](./secrets/.env) was updated to specify PRI-specific and CODE-specific environment variables

## Connection Information
-   See the CODE [connection information documentation](https://github.com/noaa-pifsc/PIFSC-Containerized-Oracle-Development-Environment?tab=readme-ov-file/-/blob/main/README.md?ref_type=heads#connection-information) for details
-   ### DSC Database Connection Information
    -   Connection information can be found in [create_docker_schemas.sql](https://picgitlab.nmfs.local/centralized-data-tools/pifsc-dsc/-/blob/main/SQL/dev_container_setup/create_docker_schemas.sql?ref_type=heads)
-   ### PRI Database Connection Information
    -   Connection information can be found in [create_docker_schemas.sql](https://picgitlab.nmfs.local/centralized-data-tools/pifsc-resource-inventory/-/blob/master/shared_SQL/dev_container_setup/create_docker_schemas.sql?ref_type=heads)