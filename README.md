My Movies API
=============

[![Build Status](https://travis-ci.org/movies-app/mymovies-api.svg?branch=master)](https://travis-ci.org/movies-app/mymovies-api)

## GitHub

…or create a new repository on the command line
```bash
echo "# mymovies-api" >> README.md
git init
git add README.md
git commit -m "first commit"
git remote add origin https://github.com/movies-app/mymovies-api.git
git push -u origin master
```

…or push an existing repository from the command line
```bash
git remote add origin https://github.com/movies-app/mymovies-api.git
git push -u origin master
```

## Travis-CI
Go to [Travis-CI Profile page](https://travis-ci.org/profile)

1. Flick the repository switch on
2. Add .travis.yml file to your repository
3. Trigger your first build with a git push

## Heroku

### Heroku CLI

[Deploying Spring Boot apps to Heroku](https://devcenter.heroku.com/articles/deploying-spring-boot-apps-to-heroku)

Although Spring Boot apps can be deployed to Heroku following the instructions in the web page, we can add a custom
`Procfile` in the project root with a custom command such as:
```bash
web: java -Dserver.port=$PORT -jar target/mymovies-api-0.0.1-SNAPSHOT.jar
```

Files:
1. Procfile (Optional, since we are deploying a Spring Boot app)
2. system.properties (Optional, in case we wanted to specify custom properties)

### Commands
```bash
heroku login
heroku create //Alternatively: heroku create -n
git push heroku master
heroku open
heroku logs --tail
```
### Heroku Maven Plugin

[Deploying Java applications with the Heroku Maven plugin](https://devcenter.heroku.com/articles/deploying-java-applications-with-the-heroku-maven-plugin)

```xml
<plugin>
    <groupId>com.heroku.sdk</groupId>
    <artifactId>heroku-maven-plugin</artifactId>
    <version>1.1.3</version>
</plugin>
```

#### Deploy WAR
```bash
mvn clean heroku:deploy-war
```
#### Deploy Standalone app
```bash
mvn clean heroku:deploy

```

## Notes
Note the use of the `@AutoConfigureMockMvc` together with @SpringBootTest to inject a MockMvc instance.

Having used `@SpringBootTest` we are asking for the whole application context to be created. An alternative would be to
ask Spring Boot to create only the web layers of the context using the `@WebMvcTest`.

Spring Boot automatically tries to locate the main application class of your application in either case, but you can
override it, or narrow it down, if you want to build something different.

## Other resources

[Getting started with Spring Boot](https://spring.io/guides/gs/spring-boot/)