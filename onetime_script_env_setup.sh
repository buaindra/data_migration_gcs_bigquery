#Created by: Indranil Pal
#Created Date: 08-11-2021
#Modified Date:


#Variables
#Change the variables
export PROJECT_ID=pure-particle-321405 
#Fixed variables
export COMPOSER_ENV=composer-test-env
export ENVIRONMENT_NAME=data-migration-cloudstorage
export LOCATION=us-central1

#Set the GCP Project
gcloud config set project $PROJECT_ID

#Enable the Composer API
gcloud services enable composer.googleapis.com

#Create Composer Environment
gcloud composer environments create $ENVIRONMENT_NAME --location $LOCATION