#!/bin/bash
# 可将该脚本link到bin目录下实现快速部署 ln ${HOME}/Workspace/Github/hch814/maven-repo/deploy.sh /usr/local/bin/mvn-deploy
set -e

TO_BE_DEPLOYED_PROJ_PATH=$1
if [ -z ${TO_BE_DEPLOYED_PROJ_PATH} ]; then
    TO_BE_DEPLOYED_PROJ_PATH='.'
fi
cd ${TO_BE_DEPLOYED_PROJ_PATH}

until [ -e './pom.xml' ] || [ `pwd` = '/' ]
do
    cd ..
done
if [ `pwd` = '/' ]; then
    echo -e "\033[31;1mpom.xml not found, not a maven project, cannot deploy" 1>/dev/stderr
    exit -1
fi
TO_BE_DEPLOYED_PROJ_PATH=`pwd`
TO_BE_DEPLOYED_PROJ_NAME=`basename ${TO_BE_DEPLOYED_PROJ_PATH}`
echo "maven project '${TO_BE_DEPLOYED_PROJ_NAME}' detected"

MAVEN_REPO=${HOME}/Workspace/Github/hch814/maven-repo/repository
mvn clean deploy -DskipTests  -DaltDeploymentRepository=self-mvn-repo::default::file:${HOME}/Workspace/Github/hch814/maven-repo/repository
cd ${MAVEN_REPO}
git add .
git commit -m "update repo '${TO_BE_DEPLOYED_PROJ_NAME}'"
git push