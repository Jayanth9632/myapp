pipeline {
    agent any

    environment {
        // Docker image name (replace with your actual Docker Hub username)
        DOCKER_IMAGE = 'your-dockerhub-username/demo:latest'

        // SonarQube server name configured in Jenkins
        SONARQUBE_ENV = 'MySonarQube'

        // Jenkins credentials IDs
        GIT_CREDENTIALS_ID = 'github-pat'          // GitHub PAT
        DOCKER_CREDENTIALS_ID = 'dockerhub-creds'  // Docker Hub login
    }

    stages {
        stage('📥 Checkout') {
            steps {
                // Clone the GitHub repo using stored credentials
                git credentialsId: "${GIT_CREDENTIALS_ID}", url: 'https://github.com/Jayanth9632/myapp.git'
            }
        }

        stage('🔍 SonarQube Analysis') {
            steps {
                // Run static code analysis
                withSonarQubeEnv("${SONARQUBE_ENV}") {
                    sh 'mvn clean verify sonar:sonar'
                }
            }
        }

        stage('⚙️ Build') {
            steps {
                // Compile and package the Spring Boot app
                sh 'mvn clean package'
            }
        }

        stage('🛡️ Trivy Scan') {
            steps {
                // Run vulnerability scan on Docker image
                sh 'chmod +x scripts/trivy-scan.sh'
                sh './scripts/trivy-scan.sh'
            }
        }

        stage('🐳 Docker Build & Push') {
            steps {
                // Login and push Docker image securely
                withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS_ID}", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker build -t ${DOCKER_IMAGE} .
                        docker push ${DOCKER_IMAGE}
                    """
                }
            }
        }

        stage('🚀 Kubernetes Deploy') {
            steps {
                // Deploy to Kubernetes cluster
                sh 'chmod +x scripts/kubernetes-deploy.sh'
                sh './scripts/kubernetes-deploy.sh'
            }
        }
    }
}
