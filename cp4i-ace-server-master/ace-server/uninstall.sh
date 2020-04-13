#!/bin/bash

PROJECT=ace-deploy
RELEASE=$PROJECT-dev

helm delete $RELEASE --purge --tls

if [ "$CLOUD_TYPE" != "ibmcloud" ]; then oc delete -f pv.yaml; fi;

echo "Uninstall of Ace Server is now complete"
echo
 
