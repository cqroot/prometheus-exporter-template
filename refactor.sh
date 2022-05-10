#!/bin/bash

USAGE="USAGE:\nbash refactor.sh new-exporter"

main ()
{
    NEW_NAME=$1

    if [ -z "${NEW_NAME}" ]; then
        echo -e ${USAGE}
        exit 1
    fi

    echo "New project name: ${NEW_NAME}"

    grep -l --exclude='refactor.sh' --exclude-dir='.git' -rn 'prometheus-exporter-template' | xargs -i sed -i "s/prometheus-exporter-template/${NEW_NAME}/g" {}
    mv systemd/prometheus-exporter-template.service systemd/${NEW_NAME}.service
    mv conf/prometheus-exporter-template.yml conf/${NEW_NAME}.yml
}

main $1
