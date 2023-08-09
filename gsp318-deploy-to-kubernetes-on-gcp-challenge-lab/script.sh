#!/bin/bash 

set -x

function raise_error {
  echo "####################################################"
  echo "####################################################"
  echo "####################################################"
  echo "####################################################"
  echo "Failing deployment due to error in: $1"
  echo "####################################################"
  echo "####################################################"
  echo "####################################################"
  echo "####################################################"
  gcloud beta runtime-config configs variables set \
           failure/workstation-waiter \
           failure --config-name workstation-installer-config
}

### Set Zone
gcloud config set compute/zone us-east1-d

git clone https://github.com/GoogleCloudPlatform/continuous-deployment-on-kubernetes.git

cd continuous-deployment-on-kubernetes

### Create Cluster
gcloud container clusters create valkyrie-dev --num-nodes 2 --machine-type n1-standard-2 --scopes "https://www.googleapis.com/auth/source.read_write,cloud-platform"

sleep 15

gcloud container clusters get-credentials valkyrie-dev

wget https://storage.googleapis.com/kubernetes-helm/helm-v2.14.1-linux-amd64.tar.gz

tar zxfv helm-v2.14.1-linux-amd64.tar.gz

cp linux-amd64/helm .

kubectl create clusterrolebinding cluster-admin-binding --clusterrole=cluster-admin --user=$(gcloud config get-value account)
sleep 5

kubectl create serviceaccount tiller --namespace kube-system
sleep 5

kubectl create clusterrolebinding tiller-admin-binding --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
sleep 5

./helm init --service-account=tiller
sleep 5

# wait for tiller to initialize
kubectl -n kube-system wait --for=condition=Ready pod -l name=tiller --timeout=300s

./helm update
sleep 5

./helm install -n cd stable/jenkins -f jenkins/values.yaml --version 1.2.2 --wait
sleep 5

kubectl create clusterrolebinding jenkins-deploy --clusterrole=cluster-admin --serviceaccount=default:cd-jenkins

export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/component=jenkins-master" -l "app.kubernetes.io/instance=cd" -o jsonpath="{.items[0].metadata.name}")
kubectl port-forward $POD_NAME 8080:8080 >> /dev/null &

printf "Waiting on Jenkins to come online"
while [ $(curl -I http://localhost:8080/login | grep -c "HTTP/1.1 200") -ne 1 ]
do
  printf "."
  sleep 5
done
echo ""

gcloud beta runtime-config configs variables set \
          success/workstation-waiter \
          success --config-name workstation-installer-config


