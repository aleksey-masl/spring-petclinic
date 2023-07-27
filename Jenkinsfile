pipeline {
    agent none
    environment {
        // replace github_token with the copy pasted iD
        SERVICE_NAME = spring-petclinic
            }
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
                sh """ if [ \$(docker ps --format '{{.Names}}' | grep -w ${SERVICE_NAME} &> /dev/null) ]; then
                     docker rm -f ${SERVICE_NAME};
                   fi;
                """
                sh "docker build -t ${SERVICE_NAME}:v1 ."
                sh "docker tag ${SERVICE_NAME}+:v1 localhost:5000/+${SERVICE_NAME}+:v1"
                sh "docker run -dp 8081:8080 --name ${SERVICE_NAME} --restart=always localhost:5000/+${SERVICE_NAME}+:v1"
            }
        }
    }
}
