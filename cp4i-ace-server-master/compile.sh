#!/bin/bash

source /opt/IBM/ace-11.0.0.7/server/bin/mqsiprofile
mqsicreatebar -data . -b ${JOB_NAME}.bar -a ${JOB_NAME}
mqsiapplybaroverride -b ${JOB_NAME}.bar -p ${JOB_NAME}/properties/DEV.properties -o ${JOB_NAME}_DEV_${BUILD_NUMBER}.bar -r
mqsiapplybaroverride -b ${JOB_NAME}.bar -p ${JOB_NAME}/properties/QA.properties -o ${JOB_NAME}_QA_${BUILD_NUMBER}.bar -r
zip ${JOB_NAME}.zip ${JOB_NAME}_DEV_${BUILD_NUMBER}.bar ${JOB_NAME}_QA_${BUILD_NUMBER}.bar