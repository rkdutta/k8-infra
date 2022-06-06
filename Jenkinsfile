// Uses Declarative syntax to run commands inside a container.
pipeline {
    agent {
        kubernetes {
            yaml '''
            apiVersion: v1
            kind: Pod
            spec:
              containers:
              - name: dokcer
                image: docker:latest
            '''
            defaultContainer 'shell'
        }
    }
    triggers {
        pollSCM('* * * * *')
    }
    stages {
        // stage('Main') {
        //     steps {
        //         sh 'hostname'
        //         sh 'apt install -y docker.io'
        //         sh 'docker image ls'
        //     }
        // }
        stage('Push') {
            steps {
              container('docker') {
                sh """
                   docker build -t spring-petclinic-demo:$BUILD_NUMBER .
                """
              }
            }
          }
    }
}
