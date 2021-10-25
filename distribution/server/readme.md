# Installation on a root server

## docker and docker-compose
docker and docker-compose must be installed

## systemd service

In order to start the application on boot you have to enable the docker-compose service by adding
[docker-compose.service](./docker-compose.service) to /lib/systemd/system and enable it.

~~~bash
sudo cp docker-compose.service /lib/systemd/system
systemctl enable docker-compose
~~~
