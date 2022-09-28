pipeline {

    environment {
        dockerimagename = "nimishjoseph/nodejssep:latest"
        dockerImage = ""
    }

    agent any

    stages {

        stage('Checkout Source') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Nimo32/node-helloworld.git']]])
            }
        }
        stage('Build the Dockerfile') {
            steps {
                script {
                    sh "docker build -t nimishjoseph/nodejssep:latest ."
                }
            }

        }
        stage('Push to Dockerhub') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'dockerhubidpass', variable: 'dockerhubpassword')]) {
                        sh "docker login -u nimishjoseph -p ${dockerhubpassword}"
                    }
                    sh "docker push nimishjoseph/nodejssep:latest "

                }
            }
        }
        stage('Deploying to the Kubeadm Cluster') {
            steps {
                script {
                    sh "kubectl delete deploy nodejs-app && kubectl delete svc nodejs-app-svc "
                    sh "kubectl apply -f node-app-deployment-service.yaml"

                }
            }
        }
    }
}
