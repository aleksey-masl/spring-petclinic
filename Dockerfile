FROM anapsix/alpine-java
LABEL authors="Алексей"
COPY /target/spring-petclinic-3.1.0-SNAPSHOT.jar /home/spring-petclinic-3.1.0-SNAPSHOT.jar
EXPOSE 8080
CMD ["java","-jar","/home/spring-petclinic-3.1.0-SNAPSHOT.jar"]
