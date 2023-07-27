pipeline {
    agent none

    stages {
        stage('maven build') {
            agent{
                docker {
                    image 'maven:3.5.0'
                    args '-v $HOME/.m2:/root/.m2'
                }
            }
            steps {
                sh "mvn clean install -Dmaven.test.skip -Dcheckstyle.skip"
            }
        }
        stage('maven test') {
            agent{
                docker {
                    image 'maven:3.5.0'
                    args '-v $HOME/.m2:/root/.m2'
                }
            }
            steps {
                sh "mvn test -Dcheckstyle.skip"
            }
        }
    }
}
