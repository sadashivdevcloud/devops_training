
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

<img width="960" alt="k8 setup on gke" src="https://github.com/user-attachments/assets/3f994f06-fc2f-4067-a22a-56de89a86337" />

