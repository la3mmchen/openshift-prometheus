#!/bin/bash

# path to binary
oc='/usr/local/bin/oc'

# add policies for scraping k8s api
$oc login -u system:admin > /dev/null
$oc adm policy add-cluster-role-to-user cluster-reader system:serviceaccount:paas-monitoring:default

# work with paas user
$oc login -u paas -p p44s > /dev/null

# add storage
$oc create -f prometheus/persistent-volumes.yml

# delete everything
$oc delete all -l app=prometheus
$oc delete template prometheus

# create configmaps
$oc create configmap prometheus-config --from-file=prometheus/prometheus.yml
$oc create configmap prometheus-alert-applications --from-file=prometheus/alert-applications.rule


# add template
$oc create -f prometheus/openshift-template.json

# create app
$oc new-app --template=prometheus --param=APPLICATION_NAME=prometheus
