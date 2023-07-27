pipeline {
    agent none

    stages {
        stage('maven build') {
            agent{
                docker {
                    image 'maven:3.8.3-openjdk-17'
                    args '-v $HOME/.m2:/root/.m2'
                }
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
