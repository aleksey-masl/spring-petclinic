pipeline {
    agent {label "linux"}

    tools {maven "maven-3.8.6"}

    stages {
        stage('maven build') {
            steps {
                sh "mvn clean install -Dmaven.test.skip"
            }
        }
        stage('maven test') {
            steps {
                sh "mvn test"
            }
        }
    }
}
