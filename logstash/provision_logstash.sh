#!/bin/bash

# path to binary
oc='/usr/local/bin/oc'

# login as developer & initialize project
$oc login -u paas -p p44s > /dev/null

# delete everything
$oc delete all -l app=logstash
$oc delete template logstash
$oc delete configmap logstash-config

# create configmap
$oc create configmap logstash-config --from-file=logstash.yml=logstash/logstash.yml --from-file=log4j2.properties=logstash/log4j2.properties --from-file=jvm.options=logstash/jvm.options  --from-file=logstash.conf=logstash/logstash.conf

# add template
$oc create -f logstash/openshift-template.json

# create app
$oc new-app --template=logstash --param=APPLICATION_NAME=logstash
