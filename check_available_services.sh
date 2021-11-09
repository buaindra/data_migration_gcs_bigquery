#!/bin/bash

Project_ID="$1"

Return_Message=`gcloud services list --enabled --project "$Project_ID"`

echo $Return_Message