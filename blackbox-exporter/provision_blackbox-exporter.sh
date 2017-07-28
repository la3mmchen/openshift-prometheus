#!/bin/bash

# path to binary
oc='/usr/local/bin/oc'

# login as developer & initialize project
$oc login -u paas -p p44s > /dev/null

# delete everything
$oc delete all -l app=blackbox-exporter
$oc delete template blackbox-exporter

# create configmaps
$oc create configmap blackbox-exporter-config --from-file=blackbox-exporter/blackbox-exporter.yml

# add template
$oc create -f blackbox-exporter/openshift-template.json

# create app
$oc new-app --template=blackbox-exporter --param=APPLICATION_NAME=blackbox-exporter
