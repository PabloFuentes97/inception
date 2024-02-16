CONTAINERS = nginx wordpress mariadb
VOLUMES = volumes/wordpress volumes/mariadb
#hacer version individual de comandos para poder personalizar qué contenedor tomar como argumento
build: $(CONTAINERS) $(VOLUMES)
	docker compose -f docker-compose.yml build $(CONTAINERS)
	mkdir $(VOLUMES)
up: $(CONTAINERS)
	docker compose -f docker-compose.yml up $(CONTAINERS)
start: $(CONTAINERS)
	docker compose -f docker-compose.yml start $(CONTAINERS)
down: $(CONTAINERS)
	docker compose -f docker-compose.yml down $(CONTAINERS)
destroy: $(CONTAINERS) $(VOLUMES)
	docker compose -f docker-compose.yml destroy $(CONTAINERS)
	rm -rf $(VOLUMES)
stop: $(CONTAINERS)
	docker compose -f docker-compose.yml stop $(CONTAINERS)
restart: $(CONTAINERS)
	docker compose -f docker-compose.yml restart $(CONTAINERS)
ps:
	docker compose -f docker-compose.yml ps
nginx:
	docker compose -f docker-compose.yml exec nginx /bin/bash
wordpress:
	docker compose -f docker-compose.yml exec wordpress /bin/bash
mariadb:
	docker compose -f docker-compose.yml exec mariadb /bin/bash
.PHONY: build up start down destroy stop restart ps nginx wordpress mariadb