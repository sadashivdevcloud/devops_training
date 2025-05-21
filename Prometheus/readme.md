# Installing Prometheus on GKE Cluster Using Helm

## Prerequisites

Before installing Prometheus on a Google Kubernetes Engine (GKE) cluster, ensure you have the following:

* A running GKE cluster
* `kubectl` configured to access the GKE cluster
* Helm installed (version 3 or later)

## Step 1: Add Prometheus Helm Repository

Add the Prometheus Community Helm repository and update it:

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```

## Step 2: Create a Namespace

Create a dedicated namespace for Prometheus:

```bash
kubectl create namespace monitoring
```

## Step 3: Install Prometheus Using Helm

Install the `kube-prometheus-stack` chart which includes Prometheus, Grafana, Alertmanager, and other components:

```bash
helm install prometheus prometheus-community/kube-prometheus-stack \
  --namespace monitoring
```

## Step 4: Verify Installation

Check that all Prometheus-related pods are running:

```bash
kubectl get pods -n monitoring
```

You should see pods such as:

* `prometheus-kube-prometheus-stack-prometheus`
* `prometheus-kube-prometheus-stack-grafana`
* `alertmanager`
* Node exporters
* Kube-state-metrics

## Step 5: Access Prometheus UI

Use port forwarding to access the Prometheus web UI:

```bash
kubectl port-forward svc/prometheus-kube-prometheus-stack-prometheus -n monitoring 9090
```

Then open:

```
http://localhost:9090
```

## Step 6: Access Grafana UI

Port forward the Grafana service:

```bash
kubectl port-forward svc/prometheus-kube-prometheus-stack-grafana -n monitoring 3000
```

Then open:

```
http://localhost:3000
```

Default login credentials:

* Username: `admin`
* Password: `prom-operator`

These can be changed via Helm values.

## Optional: Customize Configuration

To customize your Prometheus installation:

```bash
helm show values prometheus-community/kube-prometheus-stack > custom-values.yaml
# Edit the file as needed
helm install prometheus prometheus-community/kube-prometheus-stack \
  -n monitoring -f custom-values.yaml
```

## Conclusion

You have successfully installed Prometheus on your GKE cluster using Helm. This setup provides powerful monitoring capabilities with integrated Grafana dashboards, alerting, and metric collection.
