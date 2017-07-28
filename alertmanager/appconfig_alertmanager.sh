#!/bin/bash

# path to binary
oc='/usr/local/bin/oc'

# work with paas user
$oc login -u paas -p p44s > /dev/null

# delete configmaps
$oc delete configmap alertmanager-config

# create configmaps
$oc create configmap alertmanager-config --from-file=alertmanager/alertmanager.yml

# rollout
$oc rollout latest alertmanager
