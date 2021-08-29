resource "google_bigquery_dataset" "dataset" {
        dataset_id                  = "srebootstackdriver"
        friendly_name               = "sreboot"
        description                 = "Pushing logs to bigquery"
        #location                    = "EU"

        labels = {
            env = "default"
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
  filter      = "resource.type = gce_instance"

  unique_writer_identity = true
}

resource "google_bigquery_table" "logsink" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = "bar"

  time_partitioning {
    type = "HOUR"
  }

  labels = {
    env = "default"
  }
}
