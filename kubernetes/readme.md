
# GKE Cluster Creation Guide

This guide provides step-by-step instructions to create a Kubernetes cluster in **Google Kubernetes Engine (GKE)** using both the **Google Cloud Console** and **gcloud CLI**.

---

## 🚀 Method 1: Using Google Cloud Console (UI)

1. Log in to [Google Cloud Console](https://console.cloud.google.com/).
2. Navigate to **Kubernetes Engine > Clusters**.
3. Click **"Create"**.
4. Choose a cluster mode:
   - **Standard** (manual control of node infrastructure)
   - **Autopilot** (GKE manages infrastructure automatically)
5. Fill in cluster configuration:
   - Cluster name
   - Region/Zone
   - Number of nodes
   - Machine type (e.g., `e2-medium`)
6. (Optional) Configure advanced settings like networking, node pools, logging, etc.
7. Click **"Create"**.
8. Wait for the cluster to be provisioned.

---

## 🧩 Method 2: Using gcloud CLI

### ✅ Prerequisites
- Install [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
- Ensure you have a Google Cloud project with billing enabled

### 🔧 Steps

1. Authenticate with Google Cloud:

   ```bash
   gcloud auth login
   gcloud config set project YOUR_PROJECT_ID

2.Enable the GKE API:

    gcloud services enable container.googleapis.com

3.Create a Kubernetes cluster:

     gcloud container clusters create my-cluster \
     --zone us-central1-a \
     --num-nodes 3

4.Get cluster credentials to use with kubectl:

     gcloud container clusters get-credentials my-cluster --zone us-central1-a

5.Verify the cluster:

       kubectl get nodes



<img width="960" alt="k8 setup on gke" src="https://github.com/user-attachments/assets/3f994f06-fc2f-4067-a22a-56de89a86337" />

Setting up a simple web application with deployment in Kubernetes (K8s) involves several steps.
Below is a guide to help you get started:

1. Prepare Your Application
Ensure you have a simple web application (e.g., built with Node.js, Python Flask, or any framework).
Create a Dockerfile to containerize your application.

Example Dockerfile:

FROM node:18
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 8080
CMD ["node", "app.js"]

2. Build and Push Your Docker Image.

1.Build the image:

docker build -t <your-dockerhub-username>/<image-name>:<tag> .

2.Push the image to Docker Hub:

docker push <your-dockerhub-username>/<image-name>:<tag>

3.. Write Kubernetes Manifest Files

You need two main resources: Deployment and Service.

deployment.yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: webapp-deployment
  labels:
    app: webapp
spec:
  replicas: 3
  selector:
    matchLabels:
      app: webapp
  template:
    metadata:
      labels:
        app: webapp
    spec:
      containers:
      - name: webapp
        image: <your-dockerhub-username>/<image-name>:<tag>
        ports:
        - containerPort: 8080
		
service.yaml

apiVersion: v1
kind: Service
metadata:
  name: webapp-service
spec:
  selector:
    app: webapp
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
  type: LoadBalancer
  
 
 4. Deploy to Kubernetes
 
 1.Apply the manifests:
 
 kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

2.Verify the deployment and service:

kubectl get deployments
kubectl get services

5. Access Your Application

If you are using a cloud provider like AWS, GCP, or Azure, the service of type LoadBalancer will provision a public IP.
Use the external IP to access your application in the browser.

6. Optional Enhancements

Use ConfigMaps and Secrets for externalized configuration.
Use Ingress for better routing and domain management.
Monitor your application with tools like Prometheus and Grafana.


