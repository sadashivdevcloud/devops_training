
# 🚀 SonarQube Setup with Docker Compose + GitHub Actions Integration

## 📖 Overview

This project demonstrates how to:

- Set up SonarQube using Docker Compose
- Run static code analysis for a Java project
- Integrate with GitHub Actions CI/CD pipeline

---

## 🧰 Prerequisites

- Ubuntu 22.04 EC2 instance (minimum `t2.medium` with 4GB RAM)
- Port `9000` open in your EC2 security group
- Java project hosted on GitHub

---

## 🛠️ Setup Instructions

### 1. Configure System Settings for SonarQube

```bash
sudo nano /etc/sysctl.conf
```

Add at the bottom:

```bash
vm.max_map_count=262144
fs.file-max=65536
```

Apply changes:

```bash
sudo sysctl -p
```

Optional: Set hostname

```bash
sudo hostnamectl set-hostname SonarQube
```

Update system packages:

```bash
sudo apt update
```

### 2. Install Docker Compose

```bash
sudo apt install docker-compose -y
```

### 3. Create `docker-compose.yml`

```yaml
version: "3"
services:
  sonarqube:
    image: sonarqube:community
    restart: unless-stopped
    depends_on:
      - db
    environment:
      SONAR_JDBC_URL: jdbc:postgresql://db:5432/sonar
      SONAR_JDBC_USERNAME: sonar
      SONAR_JDBC_PASSWORD: sonar
    volumes:
      - sonarqube_data:/opt/sonarqube/data
      - sonarqube_extensions:/opt/sonarqube/extensions
      - sonarqube_logs:/opt/sonarqube/logs
    ports:
      - "9000:9000"

  db:
    image: postgres:12
    restart: unless-stopped
    environment:
      POSTGRES_USER: sonar
      POSTGRES_PASSWORD: sonar
    volumes:
      - postgresql:/var/lib/postgresql
      - postgresql_data:/var/lib/postgresql/data

volumes:
  sonarqube_data:
  sonarqube_extensions:
  sonarqube_logs:
  postgresql:
  postgresql_data:
```

### 4. Start SonarQube

```bash
sudo docker-compose up -d
```

Check logs:

```bash
sudo docker-compose logs --follow
```

### 5. Access SonarQube UI

Go to your browser:

```
http://<EC2-PUBLIC-DNS>:9000
```

Default credentials:
- Username: `admin`
- Password: `admin`

---

## 🔐 GitHub Actions Integration

### 1. Create SonarQube Token

1. Login to SonarQube
2. Go to **My Account > Security**
3. Generate a new **Token**
4. Copy and store it securely

### 2. Add Secrets in GitHub

In your GitHub repo, go to:
**Settings > Secrets and Variables > Actions > New repository secret**

Add:

| Name            | Value                                |
|-----------------|--------------------------------------|
| `SONAR_TOKEN`   | SonarQube token                      |
| `SONAR_HOST_URL`| `http://<EC2-PUBLIC-DNS>:9000`       |

### 3. Create GitHub Actions Workflow

Create file: `.github/workflows/sonar.yml`

```yaml
name: CI/CD with SonarQube Scan

on:
  push:
    branches: [main]
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Set up JDK 11
        uses: actions/setup-java@v2
        with:
          distribution: 'adopt'
          java-version: '11'

      - name: Build with Maven
        run: mvn clean install -f MyWebApp/pom.xml

      - name: Run SonarQube Scan
        uses: sonarsource/sonarqube-scan-action@master
        with:
          projectBaseDir: .
          args: >
            -Dsonar.organization=my-org
            -Dsonar.projectKey=my-Java-web-app
        env:
          SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
          SONAR_HOST_URL: ${{ secrets.SONAR_HOST_URL }}
```

---

## ✅ Result

- GitHub Actions will trigger the build and scan.
- Visit SonarQube UI to view the analysis report.

---

## 📚 References

- [SonarQube GitHub Action](https://github.com/marketplace/actions/official-sonarqube-scan)
- [SonarQube Docs](https://docs.sonarsource.com/sonarqube/latest/devops-platform-integration/github-integration/)

---

## 🧹 Cleanup

```bash
sudo docker-compose down        # Stop services
sudo docker-compose down -v     # Remove volumes
```
