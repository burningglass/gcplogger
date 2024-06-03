# Create Logging Service Account
#
# Important: Change <PROJECT_ID> to your project (check 'gcloud projects list')
#
PROJECT_ID="<PROJECT_ID>"
SA_NAME="mygcplogsa"
KEY_FILE="./sa-pk.json"

echo $PROJECT_ID
echo $SA_NAME
echo $KEY_FILE

# Ensure service account doesn't exist before attempting to create it
#
SA_EXISTS=$(gcloud iam service-accounts list --filter="${SA_NAME}" | wc -l)
if [ "$SA_EXISTS" = "0" ]; then
  # Step 1: Create service account
  #
  gcloud iam service-accounts create $SA_NAME --description="Cloud logging service account" --project=$PROJECT_ID --display-name="${SA_NAME}"

  # Step 2: Bind the logging.logWriter policy to this service account 
  #
  gcloud projects add-iam-policy-binding $PROJECT_ID \
   --member=serviceAccount:${SA_NAME}@${PROJECT_ID}.iam.gserviceaccount.com \
   --role=roles/logging.logWriter

  # Step 3: Create the key file referenced(i.e. CREDENTIALS_JSON_FILE=/path/to/?.json) by apps
  # logging to the Cloud log via this service account
  #
  gcloud iam service-accounts keys create $KEY_FILE --iam-account=${SA_NAME}@${PROJECT_ID}.iam.gserviceaccount.com
fi
