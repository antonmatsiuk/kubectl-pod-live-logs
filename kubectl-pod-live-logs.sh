#!/usr/bin/env bash

PROGNAME=$(basename $0)

function usage {
    echo "gets --folow logs from a pod with -l selector, takes first pod only!"
    echo "usage: $PROGNAME [-n NAMESPACE] [-l LABEL]"
    echo "  -n NAMESPACE K8s namespace"
    echo "  -l LABEL app=APP_LABEL"
}

function header {
    if [ -z $QUIET ]; then
        >&2 echo "###"
        >&2 echo "### $PROGNAME $*"
        >&2 echo "###"
    fi
}

while getopts :n:l:v opt; do
    case $opt in
        n)
            NAMESPACE="-n $OPTARG"
            ;;
        l)
            LABEL="-l $OPTARG"
            ;;
        \?)
            usage
            exit 0
            ;;
    esac
done


PODNAME=$(kubectl get pods $NAMESPACE  --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' $LABEL)
PODNAME=($PODNAME)
#extract first pod in case of replicasets
PODNAME=${PODNAME[0]}
kubectl logs $NAMESPACE $PODNAME -f
