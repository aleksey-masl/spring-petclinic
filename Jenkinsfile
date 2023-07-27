pipeline {
    agent none

    stages {
        stage('maven build') {
            agent{
                docker {image 'maven:3.5.0'}
            }
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
