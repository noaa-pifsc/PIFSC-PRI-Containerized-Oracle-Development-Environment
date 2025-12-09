#!/bin/bash

# define any database/apex credentials necessary to deploy the database schemas and/or applications

# define DSC schema credentials
DB_DSC_USER="DSC"
DB_DSC_PASSWORD="[CONTAINER_PW]"

# define DSC connection string
DSC_CREDENTIALS="$DB_DSC_USER/$DB_DSC_PASSWORD@${DBHOST}:${DBPORT}/${DBSERVICENAME}"

# define the DSC database folder path
DSC_FOLDER_PATH="/usr/src/DSC/SQL"

# define PRI schema credentials
DB_PRI_USER="PRI"
DB_PRI_PASSWORD="[CONTAINER_PW]"

# define PRI connection string
PRI_CREDENTIALS="$DB_PRI_USER/$DB_PRI_PASSWORD@${DBHOST}:${DBPORT}/${DBSERVICENAME}"

# define the PRI database folder path
PRI_FOLDER_PATH="/usr/src/PRI/shared_SQL"

# GIM username
DB_GIM_USER="PRI_GIM_APP"

# define GIM connection string
GIM_CREDENTIALS="$DB_GIM_USER/$DB_PRI_PASSWORD@${DBHOST}:${DBPORT}/${DBSERVICENAME}"

# RIA username
DB_RIA_USER="PRI_RIA_APP"

# define RIA connection string
RIA_CREDENTIALS="$DB_RIA_USER/$DB_PRI_PASSWORD@${DBHOST}:${DBPORT}/${DBSERVICENAME}"