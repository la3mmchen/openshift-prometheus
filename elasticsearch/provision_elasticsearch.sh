#!/bin/bash

# path to binary
oc='/usr/local/bin/oc'

# login as developer & initialize project
$oc login -u paas -p p44s > /dev/null

# delete everything
$oc delete all -l app=elasticsearch
$oc delete template elasticsearch
$oc delete configmap elasticsearch-config

# create configmap
$oc create configmap elasticsearch-config --from-file=elasticsearch.yml=elasticsearch/elasticsearch.yml --from-file=log4j2.properties=elasticsearch/log4j2.properties --from-file=jvm.options=elasticsearch/jvm.options

# add template
$oc create -f elasticsearch/openshift-template.json

# create app
$oc new-app --template=elasticsearch --param=APPLICATION_NAME=elasticsearch
