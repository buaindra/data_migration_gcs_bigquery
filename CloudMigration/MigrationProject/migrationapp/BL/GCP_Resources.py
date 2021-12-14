from google.cloud import storage
from google.cloud import bigquery


class GCP:
    def __init__(self, projid, sak_loc):
        self.projid = projid
        self.sak_loc = sak_loc

    def gcs_bucket(self):
        # storage_client = storage.Client()
        storage_client = storage.Client.from_service_account_json(self.sak_loc)
        buckets = list(storage_client.list_buckets())
        return {"buckets": buckets}




#a = GCP("poc01-330806", "D:\Self_Learning\GCP\Hcl_GCP\POC_DataMigration_To_CloudStorage\poc01-330806-f0a46a48fb50.json")
#val = a.gcs_bucket()
#print(val)

