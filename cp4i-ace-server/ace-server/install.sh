#!/bin/bash
PROJECT=ace-deploy
RELEASE=$PROJECT-dev

ACE_IMAGE=$IMAGE
# PULL_SECRET=deployer-dockercfg-wc87b
PULL_SECRET=deployer-dockercfg-pz5qh
PRODUCTION_DEPLOY=false
TLS_HOSTNAME=$(oc get routes -n kube-system | grep proxy | awk -F' ' '{print $2 }')
# In case of IBM Cloud use ibmc-file-gold for the file storage
FILE_STORAGE="nfs"
REPLICA_COUNT=1 

sed "s/PULL_SECRET/$PULL_SECRET/g"              ./ibm-ace-server-icp4i-prod/values_template.yaml  > ./ibm-ace-server-icp4i-prod/values_revised_1.yaml
sed "s/PRODUCTION_DEPLOY/$PRODUCTION_DEPLOY/g"  ./ibm-ace-server-icp4i-prod/values_revised_1.yaml > ./ibm-ace-server-icp4i-prod/values_revised_2.yaml
sed "s+ACE_IMAGE+$ACE_IMAGE+g"                   ./ibm-ace-server-icp4i-prod/values_revised_2.yaml > ./ibm-ace-server-icp4i-prod/values_revised_3.yaml
sed "s/FILE_STORAGE/$FILE_STORAGE/g"            ./ibm-ace-server-icp4i-prod/values_revised_3.yaml > ./ibm-ace-server-icp4i-prod/values.yaml 

rm ./ibm-ace-server-icp4i-prod/values_revised_1.yaml
rm ./ibm-ace-server-icp4i-prod/values_revised_2.yaml
rm ./ibm-ace-server-icp4i-prod/values_revised_3.yaml

if [ "$CLOUD_TYPE" != "ibmcloud" ]; then oc create -f pv.yaml; fi;

echo 
echo "Final values.yaml"
echo 

cat ./ibm-ace-server-icp4i-prod/values.yaml 

echo 
echo "Running Helm Install"
echo 

helm install --name $RELEASE --namespace ace  ibm-ace-server-icp4i-prod  --tls --debug
