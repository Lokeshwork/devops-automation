FROM maven:3.9.6 as build1
WORKDIR /java
COPY . .
RUN mvn clean install

FROM openjdk:11
WORKDIR /jarapp
EXPOSE 8080
COPY --from=build1 /java/target/devops-integration.jar devops-integration.jar
ENTRYPOINT ["java","-jar","/devops-integration.jar"]
