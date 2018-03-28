kubectl create -f sc.yaml
kubectl create -f pvc.yaml
helm install --name mongo \
    --set persistence.existingClaim=px-mongo-pvc \
    stable/mongodb
sleep 10
kubectl create -f api-px.yaml
kubectl scale --replicas=3 deploy/mongo-rest-api
