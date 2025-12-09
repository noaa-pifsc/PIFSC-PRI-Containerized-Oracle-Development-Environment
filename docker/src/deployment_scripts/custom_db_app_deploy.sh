#!/bin/sh

echo "running the custom database and/or application deployment scripts"

# run each of the sqlplus scripts to deploy the schemas, objects for each schema, applications, etc.
	echo "Create the DSC schemas"
	
	# change the directory to the DSC folder path so the SQL scripts can run without alterations
	cd ${DSC_FOLDER_PATH}

	# create the DSC schema(s)
sqlplus -s /nolog <<EOF
@dev_container_setup/create_docker_schemas.sql
$SYS_CREDENTIALS
EOF


	echo "Create the DSC objects"

	# change the directory to the DSC SQL folder to allow the scripts to run unaltered:
sqlplus -s /nolog <<EOF
@automated_deployments/deploy_dev_container.sql
$DSC_CREDENTIALS
EOF

	echo "the DSC objects were created"
	echo "Create the PRI schemas"
	
	# change the directory to the PRI folder path so the SQL scripts can run without alterations
	cd ${PRI_FOLDER_PATH}

	# create the PRI schema(s)
sqlplus -s /nolog <<EOF
@dev_container_setup/create_docker_schemas.sql
$SYS_CREDENTIALS
EOF


	echo "Create the PRI objects"

	# execute the PRI database deployment scripts
sqlplus -s /nolog <<EOF
@automated_deployments/deploy_dev.sql
$PRI_CREDENTIALS
EOF

	echo "the PRI objects were created"



	echo "Create the RIA objects"

	# execute the RIA database deployment scripts
sqlplus -s /nolog <<EOF
@automated_deployments/deploy_RIA_dev.sql
$RIA_CREDENTIALS
EOF

	echo "the RIA objects were created"



	echo "Create the GIM objects"

sqlplus -s /nolog <<EOF
@automated_deployments/deploy_GIM_dev.sql
$GIM_CREDENTIALS
EOF

	echo "the GIM objects were created"


	echo "SQL scripts executed successfully!"

echo "custom deployment scripts have completed successfully"
