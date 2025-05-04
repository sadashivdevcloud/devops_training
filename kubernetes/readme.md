
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



# 🚀 Deploy a Simple Web Application on Kubernetes

This guide explains how to deploy a simple Node.js web application using Docker and Kubernetes.

---

## 📦 Step 1: Prepare Your Application

Ensure you have a simple web app (e.g., built with Node.js, Flask, etc.). Below is an example `Dockerfile` to containerize a Node.js app.

**Dockerfile:**

```Dockerfile
FROM node:18
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 8080
CMD ["node", "app.js"]

**Step 2: Build and Push Your Docker Image**

1.Build the image:

docker build -t <your-dockerhub-username>/<image-name>:<tag> .

2.Push the image to Docker Hub:

docker push <your-dockerhub-username>/<image-name>:<tag>

Step 3: Create Kubernetes Manifests

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

service.yaml:
============

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

Step 4: Deploy to Kubernetes

1.Apply the manifests:

kubectl apply -f deployment.yaml
kubectl apply -f service.yaml


2.Verify the resources:

kubectl get deployments
kubectl get services

Step 5: Access Your Application

If using a cloud provider (e.g., AWS, GCP, Azure), the LoadBalancer service will expose a public IP address.
Use the external IP to access the app in your browser

