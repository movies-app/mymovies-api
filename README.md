My Movies API
=============

## GitHub

…or create a new repository on the command line
```
echo "# mymovies-api" >> README.md
git init
git add README.md
git commit -m "first commit"
git remote add origin https://github.com/movies-app/mymovies-api.git
git push -u origin master
```

…or push an existing repository from the command line
```
git remote add origin https://github.com/movies-app/mymovies-api.git
git push -u origin master
```

## Travis-CI
Go to [Travis-CI Profile page](https://travis-ci.org/profile)

1. Flick the repository switch on
2. Add .travis.yml file to your repository
3. Trigger your first build with a git push

## Heroku

[Deploying Spring Boot apps to Heroku](https://devcenter.heroku.com/articles/deploying-spring-boot-apps-to-heroku)

Although Spring Boot apps can be deployed to Heroku following the instructions in the web page, we can add a custom
`Procfile` in the project root with a custom command such as:
```
web: java -Dserver.port=$PORT -jar target/mymovies-api-0.0.1-SNAPSHOT.jar
```

Files:
1. Procfile (Optional, since we are deploying a Spring Boot app)
2. system.properties (Optional, in case we wanted to specify custom properties)

### Commands
```
heroku login
heroku create //Alternatively: heroku create -n
git push heroku master
heroku open
heroku logs --tail
```

## Notes
Note the use of the `@AutoConfigureMockMvc` together with @SpringBootTest to inject a MockMvc instance.

Having used `@SpringBootTest` we are asking for the whole application context to be created. An alternative would be to
ask Spring Boot to create only the web layers of the context using the `@WebMvcTest`.

Spring Boot automatically tries to locate the main application class of your application in either case, but you can
override it, or narrow it down, if you want to build something different.

## Other resources

[Getting started with Spring Boot](https://spring.io/guides/gs/spring-boot/)