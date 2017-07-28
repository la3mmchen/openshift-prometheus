#!/bin/bash

# path to binary
oc='/usr/local/bin/oc'

# add policies for scraping k8s api
$oc login -u system:admin > /dev/null
$oc adm policy add-cluster-role-to-user cluster-reader system:serviceaccount:paas-monitoring:default

# work with paas user
$oc login -u paas -p p44s > /dev/null

# delete everything
$oc delete all -l app=kube-state-metrics
$oc delete template kube-state-metrics

# add template
$oc create -f kube-state-metrics/openshift-template.json

# create app
$oc new-app --template=kube-state-metrics --param=APPLICATION_NAME=kube-state-metrics
