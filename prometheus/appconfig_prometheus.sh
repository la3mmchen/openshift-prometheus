#!/bin/bash
# path to binary
oc='/usr/local/bin/oc'


# work with paas user
$oc login -u paas -p p44s > /dev/null

# delete configmaps
$oc delete configmap prometheus-config
$oc delete configmap prometheus-alert-applications

# create configmaps
$oc create configmap prometheus-config --from-file=prometheus/prometheus.yml
$oc create configmap prometheus-alert-applications --from-file=prometheus/alert-applications.rule

# rollout
$oc rollout latest prometheus
