#!/bin/bash -xe
#get IP address
IP=$(kubectl describe svc nginx-ingress-controller | grep Ingress | cut -c27-)
if [ "$IP" == "" ]
then
   echo "Can't find nginx-ingress-controller External Ingress IP address!!???"
   exit -1
fi
# check user name
if [ "$USER" == "" ]
then
   echo "Can't find user name!!???"
   exit -1
fi
# send it
USER_NAME=$(echo $USER | tr -d '_')
REQUEST="{\"ip\":\"${IP}\",\"user_name\":\"${USER_NAME}\"}"
curl -H "Content-Type: application/json" -H "Authorization: bearer $(gcloud auth  print-identity-token)" https://us-central1-qwiklabs-resources.cloudfunctions.net/add-dns-record -d "${REQUEST}"
if [ $? -eq 0 ]
then
    echo Your DNS record is ${USER}.labdns.xyz
fi
