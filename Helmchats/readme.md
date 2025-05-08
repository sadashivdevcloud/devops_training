
A Helm chart packages everything needed to deploy an application or service onto a Kubernetes cluster. It includes:

Templates: YAML files with Go templating for Kubernetes resources (like Deployments, Services, ConfigMaps).

values.yaml: A configuration file where users define values to customize the deployment.

Chart metadata (Chart.yaml): Describes the chart (name, version, description).

Optional files like README.md, LICENSE, and requirements.yaml for dependencies.

# Helm Charts Overview

Helm is the package manager for Kubernetes, and Helm **charts** are its way of packaging, configuring, and deploying applications to Kubernetes clusters.

---

## 📦 What is a Helm Chart?

A **Helm chart** is a bundle of Kubernetes manifest files that describe the resources needed to run an application or service inside a Kubernetes cluster. It provides a consistent and repeatable way to deploy Kubernetes applications.

A Helm chart typically includes:

- **Templates**: Kubernetes resource definitions using Go templating.
- **`values.yaml`**: Default configuration values.
- **`Chart.yaml`**: Metadata about the chart (e.g., name, version).
- **Subcharts**: Optional dependencies stored in the `charts/` directory.

---

## 🗂️ Chart Directory Structure

```plaintext
mychart/
├── Chart.yaml          # Chart metadata
├── values.yaml         # Default configuration values
├── charts/             # Subcharts (dependencies)
├── templates/          # Kubernetes manifest templates
│   ├── deployment.yaml
│   ├── service.yaml
│   └── _helpers.tpl    # Template helper functions

