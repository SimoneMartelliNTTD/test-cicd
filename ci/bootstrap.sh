#!/bin/bash

if ( [ $# -ne 2 ] ) then
  echo "Usage: $0 <cicd-profile> <aws-region>"
  echo "<cicd-profile>: AWS connection profile for cicd account"
  echo "<aws-region>: AWS region to deploy the CI stacks"

  if ( [ "$BASH_SOURCE" = "" ] ) then
    return 1
  else
    exit 1
  fi
fi

scriptDir=$( dirname "$0" )

CiCdAccountProfile=$1
AWSRegion=$2

echo "Deploy CI pipeline"
aws --profile $CiCdAccountProfile --region $AWSRegion cloudformation deploy \
    --stack-name test-ci-pipeline \
    --template-file ${scriptDir}/bootstrap/ci-pipeline.yaml  \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameter-overrides \
      AllowedDeployAccount1=558518206506
