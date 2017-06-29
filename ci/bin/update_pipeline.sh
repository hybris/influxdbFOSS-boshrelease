#!/bin/bash

set -e

TARGET=${TARGET:-"hybris"}
PIPELINE_NAME=${PIPELINE_NAME:-"influxdbFOSS-boshrelease"}

CREDENTIALS=$(mktemp /tmp/credentials.XXXXX)

vault read -format=json -tls-skip-verify secret/concourse/$PIPELINE_NAME | jq '.data' > ${CREDENTIALS}

fly -t ${TARGET} set-pipeline -c pipeline.yml --load-vars-from=${CREDENTIALS} --pipeline=${PIPELINE_NAME}
if [ $? -ne 0 ]; then
  echo "Please login first: fly -t ${TARGET} login -k"
fi

rm -f ${CREDENTIALS}
