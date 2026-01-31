pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-user-pass')
        IMAGE_NAME = "farhaz1449/nginx-web"
    }

    stages {
        stage('Clone Code') {
            steps {
                git branch: 'main', url: 'https://github.com/yourusername/yourrepo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("$IMAGE_NAME:latest")  // Must install DockerPlugin in Jenkins
                    // sh 'docker build -t $IMAGE_NAME:latest .'
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                    // sh 'docker push $IMAGE_NAME:latest'
                    docker.push("$IMAGE_NAME:latest")
                }
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying container...'
                // You can add Kubernetes or Docker run command here
            }
        }
    }
}
