# Bare Metal Cloud Example

Example Project that demonstrates the CI/CD toolchain to automatically deploy an application to a remote server.
On every push in the master branch it automatically does the following:

- compile all parts using Github actions
- build the docker images on the github runner
- push the created docker images to the github container registry
- log into the remote server by ssh
- pull the docker images on the remote server
- start up the application on the server using docker-compose


## Deployment

The following services are deployed on the remote server:

- [nginx](https://www.nginx.com/) http server
- [quarkus](http://quarkus.io/) supersonic Microprofile Application Server ([native build](https://quarkus.io/guides/building-native-image))
- [mysql](https://www.mysql.com/) Database Server
- a small demo website written in typescript

nginx is configured to be a reverse proxy for the Application Server, so that there is no [CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS) issue when deploying javascript applications. Additionally nginx also serves the [web page](./www/readme.md) (html/css/js built with [webpack](https://webpack.js.org/)).

## Preparation of your repository

You must set the following Github secrets: 
| Name                    | Description     |
| :---------------------- | :---------- |
| [SSH_SERVER_PRIVATE_KEY](https://www.redhat.com/sysadmin/passwordless-ssh) | the private key that is allowed to log into the remote server  |
| SERVER_USER            | the username used to login into the remote server              |
| SERVER                 | IP Address or the hostname of the remote server                |
| [REGISTRY_ACCESS_TOKEN](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)  | the access token to the github container registry              |

## About login to ghcr.io

The github action will [ssh into the remote server](https://github.com/caberger/install-ssh-key), log into the container registry
and pull the docker image using commands like this:

~~~bash
 docker -u login ghcr.io -u <username> -p <access-token>
 docker pull ...
~~~

For details see the [github action](.github/workflows/ci-cd.yml) in this project.

## Service Startup
A [docker-compose.yml](https://docs.docker.com/compose/) file is copied to /usr/local/bin/application on the destination server. The services can be started manually on the server with:
~~~bash
pushd /usr/local/bin/application
docker-compose up
~~~

## auto start service at system boot 

When you want to start services at boot time please read [this](./distribution/server/readme.md).

## Cloud
To see how to deploy the same architecture to the [cloud](https://cloud.htl-leonding.ac.at/) see [this project](https://github.com/caberger/javafx-cdi-jpa)
