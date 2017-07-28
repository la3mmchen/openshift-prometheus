#!/bin/bash

# path to binary
oc='/usr/local/bin/oc'

# work with paas user
$oc login -u paas -p p44s > /dev/null
# delete everything
$oc delete all -l app=alertmanager
$oc delete template alertmanager

# create configmaps
$oc create configmap alertmanager-config --from-file=alertmanager/alertmanager.yml

# add template
$oc create -f alertmanager/openshift-template.json

# create app
$oc new-app --template=alertmanager --param=APPLICATION_NAME=alertmanager
