#Created by: Indranil Pal
#Created Date: 08-11-2021
#Modified Date:
#Variables
#Changed variables

export PROJECT_ID=poc01-330806 
#Fixed variables
export COMPOSER_ENV=data-migration-cloudstorage
export LOCATION=us-central1

#Set the GCP Project
gcloud config set project $PROJECT_ID
echo "Project has been set"

#Enable the Composer API
gcloud services enable composer.googleapis.com
echo "Composer API has been enabled"

#Create Composer Environment
gcloud composer environments create $COMPOSER_ENV --location $LOCATION
echo "Composer env has been created"




