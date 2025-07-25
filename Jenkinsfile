pipeline {
    agent any

    environment {
        GIT_CREDENTIALS_ID = 'b4961a3a-ef4b-4906-a62e-6ee49ffb6de2'  // Your GitHub PAT credential ID
        SONARQUBE_ENV = 'MySonarQube'                               // SonarQube server name
        DOCKER_IMAGE = 'jayanth9632/myapp'                          // DockerHub repo name
        DOCKER_CREDENTIALS_ID = 'docker-hub-creds'                  // DockerHub credentials ID
        KUBE_CONFIG = credentials('kubeconfig-creds')               // Kubernetes kubeconfig file
    }

    stages {
        stage('📥 Checkout') {
            steps {
                git branch: 'main',
                    credentialsId: "${GIT_CREDENTIALS_ID}",
                    url: 'https://github.com/Jayanth9632/myapp.git'
            }
        }

        stage('🔍 SonarQube Analysis') {
            steps {
                withSonarQubeEnv("${SONARQUBE_ENV}") {
                    sh 'mvn clean verify sonar:sonar'
                }
            }
        }

        stage('🔒 Trivy Scan') {
            steps {
                sh '''
                    trivy fs . --exit-code 0 --severity HIGH,CRITICAL || echo "Trivy scan completed with findings"
                '''
            }
        }

        stage('⚙️ Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('🐳 Docker Build & Push') {
            steps {
                script {
                    docker.withRegistry('', "${DOCKER_CREDENTIALS_ID}") {
                        def app = docker.build("${DOCKER_IMAGE}:${env.BUILD_NUMBER}")
                        app.push()
                    }
                }
            }
        }

        stage('🚀 Kubernetes Deploy') {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig-creds', variable: 'KUBECONFIG')]) {
                    sh '''
                        kubectl apply -f k8s/deployment.yaml
                        kubectl apply -f k8s/service.yaml
                    '''
                }
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline completed successfully!'
        }
        failure {
            echo '❌ Pipeline failed. Please check the logs for details.'
        }
    }
}
