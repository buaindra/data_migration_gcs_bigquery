gcloud auth activate-service-account username@development-123456.iam.gserviceaccount.com --key-file=service_account.json

export ACCOUNT=indranilbua.1994.01@gmail.com
export PROJECT_ID=poc01-330806
export LOCATION=us-central1

gcloud config set account $ACCOUNT
gcloud config set project $PROJECT_ID

export SERVICE_LIST=`gcloud services list --enabled --project $PROJECT_ID`
echo "$SERVICE_LIST"

export COMPOSER_ENV_LIST=`gcloud composer environments list --locations $LOCATION`
echo "$COMPOSER_ENV_LIST"