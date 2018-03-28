kubectl create -f sc-replicaset.yaml
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm install --name px --set persistentVolume.storageClass=px-ha-2-sc stable/mongodb-replicaset
#kubectl create -f api-replicaset.yaml
#kubectl scale --replicas=3 deploy/mongo-rest-api
