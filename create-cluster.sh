K8S_VERSION='1.9.4-gke.1'
ZONE='us-central1-a'
NODES='4'
MACHINE_TYPE='n1-standard-2'
DISK_SIZE='100'
DISK_TYPE='pd-ssd'
GCP_USER='fmrtl73@gmail.com'
PREEMTIBLE='true'
SSD_COUNT=0

cmd="gcloud container clusters create px --cluster-version $K8S_VERSION --machine-type $MACHINE_TYPE --image-type=ubuntu --zone=$ZONE --num-nodes=$NODES --disk-size=$DISK_SIZE"
if [ $PREEMTIBLE == 'true' ]; then
  cmd="$cmd --preemptible"
fi
if [ $SSD_COUNT -ge 1 ]; then
  cmd="$cmd --local-ssd-count $SSD_COUNT"
  `$cmd`
  gcloud container clusters get-credentials px --zone=$ZONE
  kubectl create clusterrolebinding px-cluster-admin-binding --clusterrole=cluster-admin --user=$GCP_USER
else
  `$cmd`
  gcloud container clusters get-credentials px --zone=$ZONE
  kubectl create clusterrolebinding px-cluster-admin-binding --clusterrole=cluster-admin --user=$GCP_USER
  ids=`gcloud compute instances list | grep gke-px | awk '{print $1}'`
  i=0
  for id in $ids
    do
      i=$((i +1))
      gcloud compute disks create px-$i --size $DISK_SIZE --type $DISK_TYPE
      gcloud compute instances attach-disk $id --disk px-$i
    done
fi
kubectl create -f "http://install.portworx.com:8080/?c=px-cluster-`jot  -r 1 0 1000000`&k=etcd:http://10.128.0.5:2379&kbver=$K8S_VERSION&stork=true&f=true&st=kvdb"
