kubectl create -f helm.yaml
wget https://storage.googleapis.com/kubernetes-helm/helm-v2.8.1-linux-amd64.tar.gz
mv helm-v2.8.1-linux-amd64.tar.gz /tmp
cd /tmp
gunzip helm-v2.8.1-linux-amd64.tar.gz
tar -xf helm-v2.8.1-linux-amd64.tar
cp linux-amd64/helm /usr/bin
helm init --service-account helm
cd -
