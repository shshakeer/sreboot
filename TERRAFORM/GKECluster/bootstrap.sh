gcloud container clusters get-credentials sreboot-gke --zone=us-central1

kubectl create -f deployment1.yml
kubectl create -f service1.yml
kubectl create -f hpa1.yml
