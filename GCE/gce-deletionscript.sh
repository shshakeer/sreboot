echo "Warning: You have executed deletion script to delete gce instance"
echo "Please enter name of gce instance: "
read gce
echo "Please type to delete to destroy this instance: ", $gce

read confirm

if [ $confirm = delete ]
then
echo "executing deletion script"

gcloud compute instances delete $gce --project=sreboot

else
echo "User not confirmed on deletion of gce"
fi
