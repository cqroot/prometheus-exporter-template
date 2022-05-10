#!/bin/bash

USAGE="USAGE:\nbash refactor.sh new-exporter"

refactor()
{
    grep -l --exclude='refactor.sh' --exclude-dir='.git' -rn 'prometheus-exporter-template'
}

main ()
{
    NEW_NAME=$1

    if [ -z "$NEW_NAME" ]; then
        echo -e $USAGE
        exit 1
    fi

    echo "New project name: $NEW_NAME"

    grep -l --exclude-dir='.git' -rn 'prometheus-exporter-template' | xargs -i sed "s/prometheus-exporter-template/$NEW_NAME/g" {}
}

main $1
