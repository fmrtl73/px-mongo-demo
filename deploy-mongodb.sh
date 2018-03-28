helm install --name mongo \
    stable/mongodb
sleep 10
kubectl create -f api.yaml
kubectl scale --replicas=3 deploy/mongo-rest-api
