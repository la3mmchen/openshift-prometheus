#!/bin/bash

# path to binary
oc='/usr/local/bin/oc'


# start oc cluster
while [[ `$oc cluster status > /dev/null` -ne 0 ]]
do
	echo "% oc cluster up: "
	$oc cluster up
done

# login as developer & initialize project
$oc login -u paas -p p44s > /dev/null
$oc new-project paas-monitoring > /dev/null

# provision the monitoring-stack
#./prometheus/provision_prometheus.sh
#./grafana/provision_grafana.sh
#./alertmanager/provision_alertmanager.sh
#./blackbox-exporter/provision_blackbox-exporter.sh

# provision apps
