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


## Notes
Note the use of the `@AutoConfigureMockMvc` together with @SpringBootTest to inject a MockMvc instance.

Having used `@SpringBootTest` we are asking for the whole application context to be created. An alternative would be to
ask Spring Boot to create only the web layers of the context using the `@WebMvcTest`.

Spring Boot automatically tries to locate the main application class of your application in either case, but you can
override it, or narrow it down, if you want to build something different.

## Other resources

[Getting started with Spring Boot](https://spring.io/guides/gs/spring-boot/)