CONTAINERS = nginx wordpress mariadb
VOLUMES = volumes/wordpress volumes/mariadb
init:
	mkdir $(VOLUMES)
	docker-compose -f docker-compose.yml build
build:
	docker-compose -f docker-compose.yml build
up:
	docker-compose -f docker-compose.yml up
start:
	docker-compose -f docker-compose.yml start
down:
	docker-compose -f docker-compose.yml down
destroy:
	docker-compose -f docker-compose.yml down
	docker rmi $(shell docker images -a -q)
	rm -rf $(VOLUMES)
clean:
	docker rmi $(shell docker images -a -q)
	rm -rf $(VOLUMES)
stop:
	docker compose -f docker-compose.yml stop
restart:
	docker compose -f docker-compose.yml restart
ps:
	docker compose -f docker-compose.yml ps
nginx:
	docker compose -f docker-compose.yml exec nginx /bin/bash
wordpress:
	docker compose -f docker-compose.yml exec wordpress /bin/bash
mariadb:
	docker compose -f docker-compose.yml exec mariadb /bin/bash
.PHONY: build up start down destroy stop restart ps nginx wordpress mariadb