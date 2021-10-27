# Distribution

## local debugging the jar

First we build a uber-jar
~~~bash
mvn -DskipTests -Dquarkus.package.type=uber-jar clean package
~~~

After a successful build of all subprojects all binaries and required resources
are copied to a folder for deployment.
The file assembly.yml defines what build artifacts are copied to which destination.
the target folder will contain a docker-compose.yml which you can start with
~~~bash
cd distribution/target/distribution/docker
docker-compose up --build
~~~

