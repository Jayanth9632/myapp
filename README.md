# > DevSecOps Pipeline with Terraform-Provisioned EC2

This project demonstrates a complete DevSecOps workflow for deploying a containerized Java Spring Boot application using Jenkins, Docker, Kubernetes, SonarQube, Trivy, Prometheus, Grafana, and Terraform.

---

## > Tech Stack

- **Java (Spring Boot)** – RESTful API
- **Maven** – Build automation
- **Docker** – Containerization
- **Jenkins** – CI/CD pipeline
- **SonarQube** – Code quality analysis
- **Trivy** – Vulnerability scanning
- **Kubernetes** – Container orchestration
- **Prometheus & Grafana** – Monitoring and visualization
- **Terraform** – Infrastructure provisioning (EC2)

---

## > Project Structure

myapp/ ├── src/                         # Java source code ├── pom.xml                     # Maven build file ├── Dockerfile                  # Docker image build ├── Jenkinsfile                 # Jenkins pipeline ├── sonar-project.properties    # SonarQube config ├── k8s/                        # Kubernetes manifests │   ├── deployment.yaml │   └── service.yaml ├── scripts/                    # Shell scripts for automation │   ├── trivy-scan.sh │   └── kubernetes-deploy.sh ├── monitoring/                 # Prometheus alert rules │   └── alerts.yml ├── ec2-terraform/              # Terraform EC2 provisioning │   ├── main.tf │   ├── variables.tf │   └── outputs.tf

---

## > CI/CD Pipeline Overview

1. **Code pushed to GitHub**
2. **Jenkins triggers pipeline**
3. **SonarQube scans for code quality**
4. **Trivy scans Docker image for vulnerabilities**
5. **Docker image built and pushed to Docker Hub**
6. **Application deployed to Kubernetes**
7. **Prometheus scrapes metrics**
8. **Grafana visualizes performance**
9. **Prometheus alerts on anomalies**

---

## > Infrastructure Provisioning with Terraform

Terraform scripts in `ec2-terraform/` provision an EC2 instance with:
- OpenJDK
- Docker
- Jenkins
- Security groups for SSH, Jenkins, and SonarQube

```bash
terraform init
terraform apply -auto-approve

>Monitoring & Alerting
- Prometheus scrapes metrics from the application and Kubernetes
- Grafana dashboards visualize JVM, HTTP, and container metrics
- Alert rules in alerts.yml notify on high error rates and resource usage

>How to Run Locally
# Build and run locally
mvn clean package
docker build -t demo .
docker run -p 8080:8080 demo
