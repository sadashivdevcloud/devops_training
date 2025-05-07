
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












# Django Web Application in Docker and Kubernetes

This repository demonstrates how to containerize a Django web application using Docker and deploy it to Kubernetes using Deployment and Service manifests.

---

## 📦 Docker Setup

### Dockerfile

Below is the sample `Dockerfile` that uses **Ubuntu** as the base image and runs a Python (likely Django) web application inside a **virtual environment**.

FROM ubuntu
WORKDIR /app
COPY requirements.txt /app/
COPY devops /app/
RUN apt-get update && apt-get install -y python3 python3-pip python3-venv
SHELL ["/bin/bash", "-c"]
RUN python3 -m venv venv1 && \
    source venv1/bin/activate && \
    pip install --no-cache-dir -r requirements.txt
EXPOSE 8000
CMD source venv1/bin/activate && python3 manage.py runserver 0.0.0.0:8000 

#🛠️ Build and Push Docker Image #
Step 1: Build the Image
docker build -t <your-dockerhub-username>/<image-name>:<tag> .
Step 2: Push the Image to Docker Hub
docker push <your-dockerhub-username>/<image-name>:<tag>
☸️ Kubernetes Deployment
1. Deployment Manifest (deployment.yaml)
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
2. Service Manifest (service.yaml)
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

🚀 Deploy to Kubernetes
Apply the Kubernetes manifests:

kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

Verify resources:
kubectl get deployments
kubectl get services
🌐 Access Your Application
If you're using a cloud provider like AWS, GCP, or Azure, the LoadBalancer service will expose a public IP.

Use that external IP in your browser to access the application:
http://<external-ip>


📁 Project Structure
.
├── Dockerfile
├── requirements.txt
├── devops/
│   └── manage.py
├── deployment.yaml
├── service.yaml
└── README.md


✅ Requirements
Docker
Kubernetes cluster (minikube or cloud)
kubectl CLI
Docker Hub account


created Docker image using Dockerfile and push to Dockerhub

<img width="960" alt="docker_image" src="https://github.com/user-attachments/assets/9eb09ef7-ebff-4326-be41-cec1df1af24b" />

