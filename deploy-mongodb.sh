kubectl create -f sc.yaml
kubectl create -f pvc.yaml
helm install --name px-mongo \
    --set persistence.existingClaim=px-mongo-pvc \
    stable/mongodb

