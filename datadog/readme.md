step-by-step guide to set up Datadog for application monitoring, including metrics, logs, and traces for a typical web app (like Flask/Django/Node.js/Java) on a Linux-based server:

🧩 1. Prerequisites
You need a Datadog account (free trial available).

Your application runs on a server (EC2, VPS, etc.).

Access to the server with sudo privileges.

Application logs are written to a file or stdout.

🛠️ 2. Install the Datadog Agent
bash
Copy
Edit
DD_API_KEY=<your_api_key> bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"
Replace <your_api_key> with your Datadog API key.

⚙️ 3. Enable Application Monitoring (APM)
Edit the Datadog Agent config:

bash
Copy
Edit
sudo nano /etc/datadog-agent/datadog.yaml
Set:

yaml
Copy
Edit
apm_config:
  enabled: true
Then restart the agent:

bash
Copy
Edit
sudo systemctl restart datadog-agent
🔧 4. Enable Logs Collection
Edit datadog.yaml:

yaml
Copy
Edit
logs_enabled: true
Then restart:

bash
Copy
Edit
sudo systemctl restart datadog-agent
📝 5. Configure Logs for Your App
Create a config file for your app logs:

bash
Copy
Edit
sudo mkdir -p /etc/datadog-agent/conf.d/flask_app.d/
sudo nano /etc/datadog-agent/conf.d/flask_app.d/conf.yaml
Example config:

yaml
Copy
Edit
logs:
  - type: file
    path: /var/log/myapp.log
    service: myapp
    source: python
    sourcecategory: sourcecode
Restart the agent:

bash
Copy
Edit
sudo systemctl restart datadog-agent
🔁 6. Enable Distributed Tracing (APM) for Your Language
Python Example (Flask):

Install the tracing lib:

bash
Copy
Edit
pip install ddtrace
Run the app with tracing:

bash
Copy
Edit
DD_SERVICE=myapp DD_ENV=dev ddtrace-run python app.py
Node.js Example:

bash
Copy
Edit
npm install dd-trace --save
js
Copy
Edit
const tracer = require('dd-trace').init();
🔍 7. Monitor Your Application in Datadog
Go to:

Logs → Live Tail or Log Explorer (source:python service:myapp)

APM → Services → myapp

Infrastructure → Hosts → Check if agent is sending data

🧪 8. Test Monitoring
Send test logs:

bash
Copy
Edit
echo "Test log $(date)" | sudo tee -a /var/log/myapp.log
Generate traffic or simulate requests.

📊 9. Create Dashboards and Monitors
Dashboard: Visualize metrics/logs/traces.

Monitors: Set alerts on latency, error rates, etc.

✅ Optional: Add Custom Metrics
Python example:

python
Copy
Edit
from datadog import initialize, api

options = {
    'api_key': '<your_api_key>',
    'app_key': '<your_app_key>'
}
initialize(**options)
api.Metric.send(metric='custom.metric', points=100)
