#Created by: Indranil Pal

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
bq --location=$BQ_LOC  mk --dataset --description "dataset created for database migration" $PROJECTID:$DATASET

echo "database migration env creation completed.."


