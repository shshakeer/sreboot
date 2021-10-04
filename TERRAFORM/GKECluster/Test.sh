gcloud logging sinks create test --include-children bigquery.googleapis.com/projects/sreboot/datasets/gke_logs_dataset --log-filter="resource.type='k8s_container'"

srvcacct=$(gcloud logging sinks describe test|grep writerIdentity|awk -F ' ' '{print $2}'|awk -F ':' '{print $2}'|awk -F '@' '{print $1}')
srvcacctfull=$(gcloud logging sinks describe test|grep writerIdentity|awk -F ' ' '{print $2}')
gcloud iam service-accounts create $srvcacct --display-name "test svc account" --project=sreboot

gcloud projects add-iam-policy-binding sreboot --member=$srvcacctfull --role=roles/bigquery.dataEditor


