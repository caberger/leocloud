#SHELL=/bin/bash
all:
	docker-compose up --build

stop:
	docker-compose down

clean:
	$(MAKE) stop || echo "not running"
	docker container prune --force
	docker image prune --force
	docker volume prune --force
	echo "rmi..."
	docker rmi -f $$(docker images -q)

dropdb:
	$(MAKE) stop
	docker container prune -f
	docker volume rm mysql_database

.PHONY: cleanall all stop dropdb deploy

