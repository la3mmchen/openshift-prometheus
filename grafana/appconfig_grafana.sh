#!/bin/bash

# path to binary
oc='/usr/local/bin/oc'

# work with paas user
$oc login -u paas -p p44s > /dev/null

# delete configmaps
$oc delete configmap grafana-config

# create configmaps
$oc create configmap grafana-config --from-file=grafana/grafana.ini

# rollout
$oc rollout latest grafana
