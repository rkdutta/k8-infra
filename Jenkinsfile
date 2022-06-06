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
                image: alpine:3.11
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
