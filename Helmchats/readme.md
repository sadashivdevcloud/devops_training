
A Helm chart packages everything needed to deploy an application or service onto a Kubernetes cluster. It includes:

Templates: YAML files with Go templating for Kubernetes resources (like Deployments, Services, ConfigMaps).

values.yaml: A configuration file where users define values to customize the deployment.

Chart metadata (Chart.yaml): Describes the chart (name, version, description).

Optional files like README.md, LICENSE, and requirements.yaml for dependencies.

🗂️ Helm Chart Directory Structure

mychart/
├── Chart.yaml          # Chart metadata
├── values.yaml         # Default configuration values
├── charts/             # Subcharts (dependencies)
├── templates/          # Templated Kubernetes manifests
│   ├── deployment.yaml
│   ├── service.yaml
│   └── _helpers.tpl    # Helper template functions
