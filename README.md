# The Canonical Application

This is an example project that demonstrates the [CI/CD](https://martinfowler.com/bliki/ContinuousDelivery.html) toolchain to automatically build and deploy an application to a production server.
On every push in the master branch the following actions are performed automatically to [continousely deploy](https://en.wikipedia.org/wiki/Continuous_deployment) the full system:

- compile all parts using Github actions
- build the docker images on the github runner
- push the created docker images to the github container registry
- log into the remote server by ssh
- install the required packages if they are not available yet
- pull the docker images on the remote server
- start up the application on the server using docker-compose

## Deployment

The following services are deployed on the production server:

- [nginx](https://www.nginx.com/) http server
- [quarkus](http://quarkus.io/) supersonic Microprofile Application Server ([native build via GraalVM](https://quarkus.io/guides/building-native-image))
- [mysql](https://www.mysql.com/) Database Server
- a small demo website written in typescript compiled with [webpack](https://webpack.js.org/).

nginx is configured to be a reverse proxy for the Application Server, so that there is no [CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS) issue when deploying javascript applications. Additionally nginx also serves the [web page](./www/readme.md).

## Preparation of your repository

The github runner needs access to your server. So you must specify the hostname or IP-Adress of the server, the username with sudo permission to log in and the private key used for that.
The user must be able to sudo without password, see below. The runner also needs a token to push docker images to your repository.
Of course we do not check in all that credentials in cleartext, but use github secrets for that purpose.

You must set the following [encrypted secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets): 
| Name                    | Description     |
| :---------------------- | :---------- |
| [SSH_SERVER_PRIVATE_KEY](https://www.redhat.com/sysadmin/passwordless-ssh) | the private key that is allowed to log into the server  |
| SERVER_USER            | the username used to login to the server              |
| SERVER                 | IP Address or the hostname of the server                |
| [REGISTRY_ACCESS_TOKEN](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)  | the access token to the github container registry              |

## About sudo on your server

We assume that you use an ubuntu distribution, otherwise you must change the `setup-server.sh` script to use a different package manager.

The user that is used to log into the server must have [sudo](https://manpages.ubuntu.com/manpages/xenial/man8/sudo.8.html) permission to be able to use sudo without
entering a password. 
If this is not the case add a file named `90-leocloud-users` to `/etc/sudoers.d/` with the following content:

~~~
ubuntu ALL=(ALL) NOPASSWD:ALL
~~~

If your user name is not ubuntu, then use your username instead of `ubuntu` in the line above.

## About login to ghcr.io

The github action will [ssh into the remote server](https://github.com/caberger/install-ssh-key), log into the [github container registry](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry)
and pull the docker image using commands like this:

~~~bash
echo <access-token> | docker login --username <username> --password-stdin
docker pull ...
~~~

For details see the [github action](.github/workflows/ci-cd.yml) in this project.

## Service Startup
A [docker-compose.yml](https://docs.docker.com/compose/) file is copied to `/usr/local/bin/application` on the destination server. 
A [systemctl](https://www.redhat.com/sysadmin/getting-started-systemctl) service
`docker-compose.service` is installed to `/lib/systemd/system` and enabled automatically on the production server, so the application starts up on system boot.

The services can be restarted manually and the log can be seen with:
~~~bash
cd /usr/local/bin/application
sudo systemctl restart docker-compose
docker-compose logs -f
~~~

## About the firewall

Make sure that you open port 80 on your firewall. All traffic goes through this port. 

### Using https
If you want to use https,
you must [add a certificate](https://certbot.eff.org/lets-encrypt/ubuntufocal-nginx) to nginx, expose it on port 443 and open port 443 on your firewall instead of port 80. In that case nginx terminates https and the application server does not 
need a certificate, because all internal traffic is done with http.

## Cloud
To see how to deploy the same architecture to the [cloud](https://cloud.htl-leonding.ac.at/) see the [readme in the k8s subfolder](./k8s/readme.md)
