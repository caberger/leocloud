# Bare Metal Cloud Example

The following services are deployed on the remote server:

- [nginx](https://www.nginx.com/) http server
- [quarkus](http://quarkus.io/) JEE - Application Server
- [mysql](https://www.mysql.com/) Database Server

nginx is configured to be a reverse proxy for the Application Server, so that there is no [CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS) issue when deploying javascript applications.


## Enterprise Service Stack
This example shows how to :
- build a Java REST Server (quarkus)
- create a docker image from it
- push this image to the github container registry
- add a reverse proxy to efficiently serve html and javascript and protect the application server
- log into a remote server and pull that docker image on the remote server
- install a docker-compose.yml file to start this stack



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
A [docker-compose.yml](https://docs.docker.com/compose/) file is copied to /usr/local/bin/application on the destination server. The services can be started on the server with:
~~~bash
pushd /usr/local/bin/application
docker-compose up --build
~~~

The rest is straight forward: 
- you should add a systemctl service file to automatically start that docker-compose on system boot, stop it before pulling the images and start it again after pulling.

To see how to deploy the same architecture to the [cloud](https://cloud.htl-leonding.ac.at/) see [this project](https://github.com/caberger/javafx-cdi-jpa)