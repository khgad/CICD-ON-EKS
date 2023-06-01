pipeline {
    agent {
        label 'slave'
    }

    stages {
        stage('Preparation') { 
            steps{
                git branch:"main", url:'https://github.com/khgad/simple-nodejs-app'
            }
        }
        stage('CI') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                    sh """
                    sudo docker build . -t khaledgad/simple-nodejs-app
                    sudo docker login -u ${USER} -p ${PASS}
                    sudo docker push khaledgad/simple-nodejs-app
                    """
                }
            }
        }
        stage('CD'){
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                    sh """
                    sudo docker login -u ${USER} -p ${PASS}
                    sudo docker pull khaledgad/simple-nodejs-app
                    """
                }
                sh """
                kubectl apply -f app-manifests/deployment.yml
                kubectl apply -f app-manifests/service.yml
                """
            }
        }
    }
}