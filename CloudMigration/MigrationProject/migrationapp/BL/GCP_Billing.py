from google.cloud import bigquery

class GCP_Cloud_Billing:
    def __init__(self, projid, sak_loc):
        self.projid = projid
        self.sak_loc = sak_loc

    def billing_info_1(self):
        bq_client = bigquery.Client.from_service_account_json(self.sak_loc)
        query1 = (
            "select m.billing_account_id, m.project.id, m.project.name"
            ", m.service.description, m.usage_start_time, m.usage_end_time"
            ", (select key from unnest (labels) where key in ('goog-resource-type', 'goog-composer-environment')) as labels_key"
            ", (select value from unnest (labels) where key in ('goog-resource-type', 'goog-composer-environment')) as labels_value"
            ", m.location.location, m.location.region, m.location.zone"
            ", m.usage.unit, m.usage.amount"
            ", m.cost"
            ", (select name from unnest(credits)) as credits_name"
            ", (select amount from unnest(credits)) as credits_amount"
            " from `poc01-330806.GCP_Billing.gcp_billing_export_resource_v1_01F748_D68B6C_7BFEF3` as m"
            " where m.cost > 0"
            " limit 100"
        )
        query1_job = bq_client.query(query1)
        query1_rows = query1_job.result()
        return query1_rows
