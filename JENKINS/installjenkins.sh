#/bin/bash
echo  "Building Jenkins file"

docker build -t gcr.io/sreboot/jenkinsmasterimage:v1 .

echo "Running  Jenkins on 80 port"

docker run -d -p 80:8080 gcr.io/sreboot/jenkinsmasterimage:v1

contid=$(docker ps|awk -F ' ' '{print $1}'|tail -1)

gsutil cp -r gs://jenkinsfile/fullback.zip .

docker cp fullback.zip $contid:/home/jenkins/

docker exec -it $contid sh -c "unzip /home/jenkins/fullback.zip"


