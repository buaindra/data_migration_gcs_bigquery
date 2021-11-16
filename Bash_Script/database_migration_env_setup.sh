#Created by: Indranil Pal
#Ref: https://cloud.google.com/bigquery-transfer/docs/teradata-migration#gcloud

#Variables
export PROJECTID=poc01-330806
export LOG_FILE=Database_Migration.txt
export BQ_LOC=us
export DATASET=Database-Migration

#Create a new project for data migration
#So that after migration you can delete all the resources associated with this migration process
if [[ $(gcloud projects list --format="json" | grep "$ProjectID")  ]]
then
	echo "Project already created"
else
	echo "Craeting the new project .."
fi

#Set the Project
gcloud config set project $PROJECTID

#Enables the APIs
gcloud services enable bigquery.googleapis.com

gcloud services enable bigquerydatatransfer.googleapis.com
gcloud services enable storage-component.googleapis.com
gcloud services enable pubsub.googleapis.com
echo "APIs have been enabled"

#Bigquery Dataset creation
#if [[ $(bq ls --filter "labels." --project_id $PROJECTID) ]]
if [[ ! $(bq show "$DATASET" --project_id "$PROJECTID") ]]
then
  echo "creating the dataset: $PROJECTID:$DATASET"
  bq --location=$BQ_LOC  mk --dataset --description "dataset created for database migration" $PROJECTID:$DATASET
else
  echo "dataset already created"
fi

#Create IAM Service Account (IAM Role: bigquery.admin, storage.objectAdmin)

echo "database migration env creation completed.."
