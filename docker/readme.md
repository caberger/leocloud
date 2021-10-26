# Docker and docker-compose files

This folder contains the file for the deployment on the production server and a docker-compose.yml file for running the application on docker on the local machine for debugging.
To debug on the  local machine you can run the following in the project root folder: 

## Local Debugging using uber-jar
~~~bash
mvn clean -DskipTests clean package -Dquarkus.package.type=uber-jar
cd distribution/target/distribution-0.0.1-dist/docker/
docker container prune -f
docker image prune -f
docker volume prune -f
docker-compose up --build
~~~

This will run the application on the local machine in a similar way as it is later deployed on the production server.
The native compile is not used, because the optimations it does take a very long time which is inconventient for debugging. We use an [uber-jar](https://quarkus.io/guides/maven-tooling#uber-jar-maven) instead.

After successful start you can browse the application on [localhost](http://localhost:4000) and check the [health status](http://localhost:4000/health/) and see the [REST Api](http://localhost:4000/q/openapi/)
