# leocloud
Bare Metal Cloud Example

This example shows how to :
- build a Java REST Server
- create a docker image from it
- push it to the github container registry
- log into a remote server and pull that docker image on that remote server


preparation
===

Before continuing read [Creating a personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)


You must set the following Github secrets: 
| Name                    | Description     |
| :---------------------- | :---------- |
| SSH_SERVER_PRIVATE_KEY | the private key that is allowed to log into the remote server  |
| SERVER_USER            | the username to login to the remote server        |
| SERVER                 | IP Address or the hostname of the remote server   |
| REGISTRY_ACCESS_TOKEN  | the access token to the github container registry |

Login to ghcr.io
===

The github action will ssh into the remote server and log into the container registry using this command:

~~~bash
 docker -u login ghcr.io -u <username> -p <access-token>
~~~

From there it will pull the images built in this action.
