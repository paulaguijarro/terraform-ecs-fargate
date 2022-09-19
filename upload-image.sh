#!/bin/bash

REGION_DEFAULT="eu-west-1"
NAME_DEFAULT="test-repo"
read -p "AWS ACCOUNT ID:" ACCOUNT
read -p "AWS Region [$REGION_DEFAULT]:" REGION
read -p "Repository name [$NAME_DEFAULT]:" NAME
REGION=${REGION:-$REGION_DEFAULT}
NAME=${NAME:-$NAME_DEFAULT}

aws ecr get-login-password --region ${REGION} | docker login \
    --username AWS \
    --password-stdin ${ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com

docker build -t ${NAME} --platform linux/amd64 .
docker tag ${NAME}:latest ${ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com/${NAME}:latest

docker push ${ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com/${NAME}