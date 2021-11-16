#Created by: Indranil Pal
#Created date: 16-11-2021
#Ref: https://cloud.google.com/bigquery-transfer/docs/teradata-migration#gcloud

#Variables
export PROJECTID=poc01-330806
export LOG_FILE=Database_Migration.txt
export BQ_LOC=us
export DATASET=Database-Migration
export SERVICE_ACCOUNT_ID=database-migration
export GCS_BUCKET=$PROJECTID-database-migration
export MIGRATION_DATABASE_TYPE=Teradata
export MIGRATION_DATABASE_NAME=mydatabase
export SCHEMA_FILE_PATH=""

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

#Enable the billing for that project
echo "please enable billing for this project, its still not automated.."

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
if [[ ! $(gcloud iam service-accounts list --project "$PROJECTID" --format="csv[no-heading](email)" --filter="DISABLED:False email:$SERVICE_ACCOUNT_ID@$PROJECTID.iam.gserviceaccount.com") ]]
then
	echo "Creating the service account"
	gcloud iam service-accounts create $SERVICE_ACCOUNT_ID --description="service account for database migration" --display-name=$SERVICE_ACCOUNT_ID+"-IAM"
	gcloud projects add-iam-policy-binding $PROJECTID --member="serviceAccount:$SERVICE_ACCOUNT_ID@$PROJECTID.iam.gserviceaccount.com" --role="roles/bigquery.admin"
	gcloud projects add-iam-policy-binding $PROJECTID --member="serviceAccount:$SERVICE_ACCOUNT_ID@$PROJECTID.iam.gserviceaccount.com" --role="roles/storage.objectAdmin"
	sleep 60s
else
	echo "Service Account already created or its disabled"
fi

#Create a Cloud Storage staging bucket 
#gsutil mb -p PROJECT_ID -c STORAGE_CLASS -l BUCKET_LOCATION -b on gs://BUCKET_NAME
if [[ ! $(gsutil ls | grep "$GCS_BUCKET") ]]
then
	echo "Creating staging bucket"
	gsutil mb -p $PROJECTID gs://$GCS_BUCKET
else
	echo "bucket already created"
fi

echo "database migration env creation completed.."

#Step1: Download the migration agent
echo "!!! IMPORTANT !!!"
echo "open a new tab in browser, and paste the url: https://storage.googleapis.com/data_transfer_agent/latest/mirroring-agent.jar"
while true; do
	echo "Have you downloaded the migration agent? If yes then press y and if no then press n"
	read answer
	case $answer in
		[Yy]* ) echo "going to next step"; break;;
		#[Nn]* ) exit;;
		* ) echo "Please answer yes or no.";;
	esac
done


#Step2: Set up a BigQuery Data Transfer Service transfer
bq mk --transfer_config --project_id=$PROJECTID --target_dataset=$DATASET --display_name='database migration' --params='{"bucket": "$GCS_BUCKET", "database_type": "$MIGRATION_DATABASE_TYPE", "database_name":"$MIGRATION_DATABASE_NAME", "table_name_patterns": ".*", "agent_service_account":"$SERVICE_ACCOUNT_ID@$PROJECTID.iam.gserviceaccount.com", "schema_file_path":"$SCHEMA_FILE_PATH"}' --data_source=on_premises
echo "BigQuery Data Transfer has been created"

#Step3: Initialize the migration agent

#Step4: Run the migration agent











