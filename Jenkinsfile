// Uses Declarative syntax to run commands inside a container.
pipeline {
    agent {
        kubernetes {
            yaml '''
            apiVersion: v1
            kind: Pod
            spec:
              containers:
              - name: maven-build-agent
                image: container-registry:5000/private-jdk-alpine
            '''
        }
    }
    // triggers {
    //     pollSCM('* * * * *')
    // }
    stages {
        stage('Build') {
            steps {
              git url: 'https://github.com/rkdutta/k8-notejam-code.git', branch: 'main'
            }
        }
    }
}
