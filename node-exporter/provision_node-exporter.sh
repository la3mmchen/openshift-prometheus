#!/bin/bash

# path to binary
oc='/usr/local/bin/oc'

# add policies for scraping k8s api
$oc login -u system:admin > /dev/null
$oc adm policy add-cluster-role-to-user cluster-reader system:serviceaccount:paas-monitoring:default

# work with paas user
$oc login -u paas -p p44s > /dev/null

# delete everything
$oc delete all -l app=node-exporter
$oc delete template node-exporter

# add template
$oc create -f node-exporter/openshift-template.json

# create app
$oc new-app --template=node-exporter --param=APPLICATION_NAME=node-exporter
