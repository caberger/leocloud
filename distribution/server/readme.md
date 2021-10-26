# Installation on a root server

## base installation of a Centos Minimal System

Install docker-compose, net-tools and logout to activate the membership in the docker group:
~~~bash
sudo apt -y update
sudo apt -y install docker-compose net-tools
sudo usermod -aG docker $USER
exit
~~~

## systemd service

In order to start the application automatically on every boot a [docker-compose.service](./docker-compose.service)  is added to /lib/systemd/system during the build.
