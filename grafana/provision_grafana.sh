#!/bin/bash

# path to binary
oc='/usr/local/bin/oc'

# add policies (for grafana) (as system-admin)
$oc login -u system:admin > /dev/null
$oc adm policy add-scc-to-user anyuid system:serviceaccount:paas-monitoring:default
$oc adm policy add-scc-to-user anyuid system:serviceaccount:paas-monitoring:builder
$oc adm policy add-scc-to-user anyuid system:serviceaccount:paas-monitoring:deployer

# work with paas user
$oc login -u paas -p p44s > /dev/null
# delete everything
$oc delete all -l app=grafana
$oc delete template grafana

# create configmaps
$oc create configmap grafana-config --from-file=grafana/grafana.ini

# add template
$oc create -f grafana/openshift-template.json

# create app
$oc new-app --template=grafana --param=APPLICATION_NAME=grafana
