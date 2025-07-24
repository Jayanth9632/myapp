pipeline {
  agent any

  environment {
    DOCKER_IMAGE = 'your-dockerhub-username/demo:latest'
    SONARQUBE_ENV = 'MySonarQube'
  }

  stages {
    stage('Checkout') {
      steps {
        git 'https://github.com/your-repo/myapp.git'
      }
    }

    stage('SonarQube Analysis') {
      steps {
        withSonarQubeEnv("${SONARQUBE_ENV}") {
          sh 'mvn clean verify sonar:sonar'
        }
      }
    }

    stage('Build') {
      steps {
        sh 'mvn clean package'
      }
    }

    stage('Trivy Scan') {
      steps {
        sh 'chmod +x scripts/trivy-scan.sh'
        sh './scripts/trivy-scan.sh'
      }
    }

    stage('Docker Build & Push') {
      steps {
        sh 'docker build -t ${DOCKER_IMAGE} .'
        sh 'docker push ${DOCKER_IMAGE}'
      }
    }

    stage('Kubernetes Deploy') {
      steps {
        sh 'chmod +x scripts/kubernetes-deploy.sh'
        sh './scripts/kubernetes-deploy.sh'
      }
    }
  }
}
