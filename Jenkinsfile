// Permissions for Ubuntu server where Jenkins is installed:
//     sudo usermod -aG docker jenkins
//     sudo systemctl restart jenkins
// In the Web-server where the Docker container will be deployed:
//     sudo usermod -aG docker ubuntu

pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-user-pass')
        IMAGE_NAME = "farhaz1449/nginx-web"
        USER = "ubuntu"
        PORT = "22"
        SERVER_IP = "54.226.161.122"
        APP_NAME = "nginx-web"
        VERSION = "${BUILD_NUMBER}"
    }

    stages {
        stage('Clone Code') {
            steps {
                git branch: 'main', 
                    url: 'https://github.com/farhaz1449/simple-webpage-in-Docker-Container.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME}:${VERSION} ."
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                    sh "docker push ${IMAGE_NAME}:${VERSION}"
                }
            }
        }

        stage('Deploy') {
            steps {
                sshagent(credentials: ['deploy-server-ssh']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no $USER@$SERVER_IP \
                        "docker pull $IMAGE_NAME:${VERSION} && \
                         docker rm -f $APP_NAME || true && \
                         docker run -d --name $APP_NAME -p 80:80 $IMAGE_NAME:${VERSION}"
                    '''
                }
            }
        }
    }
    
    post {
        always {
            echo "Pipeline completed. Build #${BUILD_NUMBER}"
        }
        failure {
            echo 'Deployment failed - check logs above.'
        }
        success {
            echo "Deployment successful! Check http://${SERVER_IP}"
        }
    }
}
