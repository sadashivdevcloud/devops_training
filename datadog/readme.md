# 📊 Datadog Application Monitoring Setup

This document provides a complete step-by-step guide to monitor an application using **Datadog**, including metrics, logs, and traces.

---

## 📌 Prerequisites

- A Datadog account ([sign up here](https://www.datadoghq.com))
- A valid Datadog API Key
- A running application (e.g., Flask, Node.js, Django, Java)
- Access to your Linux server (e.g., Ubuntu EC2 instance)
- `sudo` privileges on the server

---

## 🛠️ Step 1: Install the Datadog Agent

Run the following command on your server:

```bash
DD_API_KEY=<your_api_key> bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"
```

> 🔑 Replace `<your_api_key>` with your actual Datadog API key from [API Keys Settings](https://app.datadoghq.com/organization-settings/api-keys).

---

## ⚙️ Step 2: Enable APM (Application Performance Monitoring)

Edit the Datadog configuration file:

```bash
sudo nano /etc/datadog-agent/datadog.yaml
```

Uncomment or add the following section:

```yaml
apm_config:
  enabled: true
```

Restart the agent:

```bash
sudo systemctl restart datadog-agent
```

---

## 📝 Step 3: Enable Logs Collection

In the same `datadog.yaml` config file, enable logging:

```yaml
logs_enabled: true
```

Restart the agent:

```bash
sudo systemctl restart datadog-agent
```

---

## 📂 Step 4: Configure Log Collection for Your Application

Create a new directory for your application log configuration:

```bash
sudo mkdir -p /etc/datadog-agent/conf.d/flask_app.d/
sudo nano /etc/datadog-agent/conf.d/flask_app.d/conf.yaml
```

Add the following configuration:

```yaml
logs:
  - type: file
    path: /var/log/myapp.log
    service: myapp
    source: python
    sourcecategory: sourcecode
```

Restart the agent:

```bash
sudo systemctl restart datadog-agent
```

---

## 🔧 Step 5: Enable Tracing for Your App

### Python Example (Flask)

Install the Datadog tracing library:

```bash
pip install ddtrace
```

Run the app with Datadog tracing:

```bash
DD_SERVICE="myapp" DD_ENV="dev" ddtrace-run python app.py
```

### Node.js Example

Install and initialize the tracer:

```bash
npm install dd-trace
```

In your main file:

```javascript
const tracer = require('dd-trace').init();
```

---

## 📊 Step 6: Validate in Datadog

- Go to [Datadog APM](https://app.datadoghq.com/apm/services) to view traces for `myapp`
- Go to [Logs Explorer](https://app.datadoghq.com/logs/explorer/) and filter by `service:myapp`
- Go to [Infrastructure](https://app.datadoghq.com/infrastructure/) to view host metrics

---

## ✅ Step 7: Send Test Data

Test log entry:

```bash
echo "Test log from app at $(date)" | sudo tee -a /var/log/myapp.log
```

Trigger traffic to generate metrics and traces.

---

## 📊 Step 8: Create Dashboards and Monitors (Optional)

Use the Datadog UI to:

- Create custom dashboards to visualize latency, requests, error rates
- Set up monitors to alert on metrics like CPU, memory, request time, or log error patterns

---

## 📀 Optional: Send Custom Metrics (Python Example)

Install and use the `datadog` Python client:

```python
from datadog import initialize, api

options = {
    'api_key': '<your_api_key>',
    'app_key': '<your_app_key>'
}
initialize(**options)

api.Metric.send(metric='custom.metric', points=100)
```

---

<img width="960" alt="{7F430465-0F7C-4D01-A744-E801A589248F}" src="https://github.com/user-attachments/assets/4cc7adb0-79a0-4791-9c40-5cbbb597b239" />

