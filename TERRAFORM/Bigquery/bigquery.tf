resource "google_bigquery_dataset" "dataset" {
        dataset_id                  = "srebootstackdriver1"
        friendly_name               = "sreboot"
        description                 = "Pushing logs to bigquery"
        #location                    = "EU"

        lifecycle {
   	    prevent_destroy = false
  	}
        access {
            role          = "OWNER"
            user_by_email = "sreboot@sreboot.iam.gserviceaccount.com"
        }

        access {
            role   = "READER"
            domain = "hashicorp.com"
        }
    }

resource "google_logging_project_sink" "bigquery-sink" {
  name        = "gke-bigquery-sink"
  destination = "bigquery.googleapis.com/projects/${var.project_name}/datasets/${google_bigquery_dataset.dataset.dataset_id}"
  #filter      = "resource.type = container"
  filter      = "resource.type='k8s_container' resource.labels.project_id='sreboot' resource.labels.location='us-central1' resource.labels.cluster_name='sreboot-gke' resource.labels.namespace_name='default' labels.k8s-pod/app='nginx' log_name='projects/sreboot/logs/stdout'"
	lifecycle {
            prevent_destroy = false
        }

  	unique_writer_identity = false
}

resource "google_project_iam_member" "log_writer" {
    role = "roles/bigquery.dataOwner"
    member = "serviceAccount:newterraformserviceaccount@sreboot.iam.gserviceaccount.com"
}

#resource "google_bigquery_table" "logsink" {
#  dataset_id = google_bigquery_dataset.dataset.dataset_id
#  table_id   = "bar"

 # time_partitioning {
 #   type = "HOUR"
 # }

#}
