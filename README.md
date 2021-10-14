# leocloud
Bare Metal Cloud Example

This example shows how to :
- build a Java REST Server (quarkus example)
- create a docker image from it
- push this image to the github container registry
- log into a remote server and pull that docker image on the remote server


Preparation of your repository
===

Before continuing read [Creating a personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)


You must set the following Github secrets: 
| Name                    | Description     |
| :---------------------- | :---------- |
| SSH_SERVER_PRIVATE_KEY | the private key that is allowed to log into the remote server  |
| SERVER_USER            | the username used to login into the remote server              |
| SERVER                 | IP Address or the hostname of the remote server                |
| REGISTRY_ACCESS_TOKEN  | the access token to the github container registry              |

Login to ghcr.io
===

The github action will [ssh into the remote server](https://github.com/caberger/install-ssh-key), log into the container registry
and pull the docker image using commands like this:

~~~bash
 docker -u login ghcr.io -u <username> -p <access-token>
 docker pull ...
~~~

for details see the [github action](.github/workflows/ci-cd.yml)

The rest is straight forward: 
- you can use a docker-compose.yml file on the server to run your application.
- you should add a systemctl service file to automatically start that docker-compose on system boot.

