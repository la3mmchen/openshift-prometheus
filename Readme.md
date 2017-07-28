# What is this?
This is a exmaple setup for OpenShift with the prometheus stack and some example applications (Elasticsearch, Logstash).
Prometheus uses the kubernetes api for auto discovery so there is no need for any manual configuration within prometheus.

This repo contains everything for these apps to run within an OpenShift cluster:
* Prometheus
* Kube-State-Metrics (Metrics for Kubernetes)
* Node-Exporter (Metrics for the Docker Host when running as a privileged pod)
* Grafana (Dashboarding)
* Alertmanager (receiving alerts from prometheus)
* Blackbox Exporter (Probing services)
* Elasticsearch (with Elasticsearch Exporter)
* Logstash (with Logstash Exporter)

# How to use it?
Start an OpenShift Cluster and create a basic project:

    oc cluster up
    ./startup.sh

## prometheus

    ./prometheus/provision_prometheus.sh

The prometheus app config is mapped via Configmap into the prometheus pod. To update the config you can use:

    ./prometheus/appconfig_prometheus.sh

## other applications:

    ./<application>/provision_<application>.sh
