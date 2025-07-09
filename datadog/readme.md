Datadog Application Monitoring Setup

This document provides a complete step-by-step guide to monitor an application using Datadog, including metrics, logs, and traces.

📌 Prerequisites

A Datadog account (sign up here)

A valid Datadog API Key

A running application (e.g., Flask, Node.js, Django, Java)

Access to your Linux server (e.g., Ubuntu EC2 instance)

sudo privileges on the server

🛠️ Step 1: Install the Datadog Agent

Run the following command on your server:

DD_API_KEY=<your_api_key> bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"

🔑 Replace <your_api_key> with your actual Datadog API key from API Keys Settings.

⚙️ Step 2: Enable APM (Application Performance Monitoring)

Edit the Datadog configuration file:

sudo nano /etc/datadog-agent/datadog.yaml

Uncomment or add the following section:

apm_config:
  enabled: true

Restart the agent:

sudo systemctl restart datadog-agent

📝 Step 3: Enable Logs Collection

In the same datadog.yaml config file, enable logging:

logs_enabled: true

Restart the agent:

sudo systemctl restart datadog-agent

📂 Step 4: Configure Log Collection for Your Application

Create a new directory for your application log configuration:

sudo mkdir -p /etc/datadog-agent/conf.d/flask_app.d/
sudo nano /etc/datadog-agent/conf.d/flask_app.d/conf.yaml

Add the following configuration:

logs:
  - type: file
    path: /var/log/myapp.log
    service: myapp
    source: python
    sourcecategory: sourcecode

Restart the agent:

sudo systemctl restart datadog-agent

🔧 Step 5: Enable Tracing for Your App

Python Example (Flask)

Install the Datadog tracing library:

pip install ddtrace

Run the app with Datadog tracing:

DD_SERVICE="myapp" DD_ENV="dev" ddtrace-run python app.py

Node.js Example

Install and initialize the tracer:

npm install dd-trace

In your main file:

const tracer = require('dd-trace').init();

📊 Step 6: Validate in Datadog

Go to Datadog APM to view traces for myapp

Go to Logs Explorer and filter by service:myapp

Go to Infrastructure to view host metrics

✅ Step 7: Send Test Data

Test log entry:

echo "Test log from app at $(date)" | sudo tee -a /var/log/myapp.log

Trigger traffic to generate metrics and traces.

📊 Step 8: Create Dashboards and Monitors (Optional)

Use the Datadog UI to:

Create custom dashboards to visualize latency, requests, error rates

Set up monitors to alert on metrics like CPU, memory, request time, or log error patterns

📀 Optional: Send Custom Metrics (Python Example)

Install and use the datadog Python client:

from datadog import initialize, api

options = {
    'api_key': '<your_api_key>',
    'app_key': '<your_app_key>'
}
initialize(**options)

api.Metric.send(metric='custom.metric', points=100)

📚 Resources
