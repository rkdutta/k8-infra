// Uses Declarative syntax to run commands inside a container.
pipeline {
    agent {
        kubernetes {
            yaml '''
            apiVersion: v1
            kind: Pod
            spec:
              containers:
              - name: shell
                image: ubuntu
                command:
                - sleep
                args:
                - infinity
            '''
            defaultContainer 'shell'
        }
    }
    triggers {
        cron('* * * * *')
    }
    stages {
        stage('Main') {
            steps {
                sh 'hostname'
                sh 'apt install -y docker.io'
                sh 'docker image ls'
            }
        }
    }
}
