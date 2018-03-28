ids=`gcloud compute instances list | grep gke-px | awk '{print $1}'`
gcloud container clusters delete px
i=0
for id in $ids
  do
    i=$((i +1))
    gcloud compute disks delete px-$i
  done
