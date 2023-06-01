pipeline {
    agent {
        label 'slave'
    }

    stages {
        stage('Preparation') { 
            steps{
                git 'https://github.com/khgad/simple-nodejs-app'
            }
        }
        stage('CI') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                    sh """
                    docker build . -t khaledgad/simple-nodejs-app
                    docker login -u ${USER} -p ${PASS}
                    docker push khaledgad/simple-nodejs-app
                    """
                }
            }
        }
        stage('CD'){
            steps {
                sh """
                kubectl apply -f app-manifests/deployment.yml
                kubectl apply -f app-manifests/service.yml
                """
            }
        }
    }
}