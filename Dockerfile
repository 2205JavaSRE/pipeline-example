FROM openjdk:8-jre

COPY target/IntroToMicrometer-0.0.1-SNAPSHOT-jar-with-dependencies.jar demo.jar

CMD ["java","-jar","demo.jar"]
