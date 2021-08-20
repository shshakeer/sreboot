#echo "Fetching Inatllation script and dependent files from git"

#git clone https://github.com/shakeerdcm/sreboot.git

#cd sreboot

echo "building my-web-server image"

docker build -t gcr.io/sreboot/my-web-server:v1 .

echo "Pushing my-web-server image to GCR"

gcloud docker -- push gcr.io/sreboot/my-web-server:v1
