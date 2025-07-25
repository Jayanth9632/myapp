pipeline {
    agent any

    environment {
        MAIN_CLASS = 'src.main.java.com.example.demo.DemoApplication'
    }

    stages {
        stage('📦 Compile') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('🚀 Run WAR') {
            steps {
                sh 'nohup java -jar target/*.war > app.log 2>&1 &'
            }
        }
    }

    post {
        success {
            echo '✅ DemoApplication is running!'
        }
        failure {
            echo '❌ Failed to run DemoApplication.'
        }
    }
}
