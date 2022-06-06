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
            defaultContainer 'shell'
        }
    }
    // triggers {
    //     pollSCM('* * * * *')
    // }
    stages {
        stage('Main') {
            steps {
                sh 'hostname'
            }
        }
        // stage('Push') {
        //     steps {
        //       container('maven-build-agent') {
        //         sh """
        //         echo "Hello World"
        //         """
        //       }
        //     }
        //   }
    }
}
