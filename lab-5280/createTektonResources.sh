#!/bin/sh


# Create Secrets
oc create -f ./Tekton-msk/Secrets/cp4i-commonservices-secret.yaml
oc create -f ./Tekton-msk/Secrets/cp4i-docker-secret.yaml
oc create -f ./Tekton-msk/Secrets/cp4i-git-secret.yaml

# Create Resources
oc create -f ./Tekton-msk/Resources/cp4i-ace-server-source-pipelineresource.yaml
oc create -f ./Tekton-msk/Resources/cp4i-ace-server-image-pipelineresource.yaml

# Create Tasks
oc create -f ./Tekton-msk/Tasks/build-ace-server-task.yaml
oc create -f ./Tekton-msk/Tasks/install-ace-server-task.yaml

# Create Pipelines
oc create -f ./Tekton-msk/Pipelines/ace-server-deploy-pipeline.yaml
