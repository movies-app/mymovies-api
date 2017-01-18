# FROM dockerfile/java:oracle-java8
FROM moander/java8
EXPOSE 8080
CMD java -jar /mymovies-api-0.0.1-SNAPSHOT.jar
ADD target/mymovies-api-0.0.1-SNAPSHOT.jar /mymovies-api-0.0.1-SNAPSHOT.jar
