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
                sh "mvn clean install -Dmaven.test.skip -Dcheckstyle.skip"
            }
        }
        stage('maven test') {
            agent{
                docker {
                    image 'maven:3.8.3-openjdk-17'
                    args '-v $HOME/.m2:/root/.m2'
                }
            }
            steps {
                sh "mvn test -Dcheckstyle.skip"
            }
        }
        stage('release') {
            agent{
                label 'linux'
            }
            steps {
                // If thAe local registry container does not exists, create it
                sh "id"
                sh """ if ! [ \$(docker ps --format '{{.Names}}' | grep -w registry &> /dev/null) ]; then
                     docker run -d --network='host' -p 5000:5000 --restart=always --name registry registry:2;
                   fi;
                """
                // if the secret_agent container is running, delete it in order to create a new one
                sh """ if [ \$(docker ps --format '{{.Names}}' | grep -w spring-petclinic &> /dev/null) ]; then
                     docker rm -f spring-petclinic;
                   fi;
                """
                sh "docker build -t spring-petclinic:v1 ."
                sh "docker tag secretagent:v1 localhost:5000/spring-petclinic:v1"
                sh "docker run -dp 8081:8080 --name spring-petclinic --restart=always localhost:5000/spring-petclinic:v1"
            }
        }
    }
}
