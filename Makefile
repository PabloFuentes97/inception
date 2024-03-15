VOLUMES := db wordpress
VOL_DIR = /home/pfuentes/data
VOLUME = $(addprefix $(VOL_DIR)/,$(VOLUMES))
DOCKER_COMPOSE_PATH = ./srcs/docker-compose.yml

run: $(VOLUME)
	docker compose -f $(DOCKER_COMPOSE_PATH) up --build --remove-orphans

stop:
	docker compose -f $(DOCKER_COMPOSE_PATH) stop

down:
	docker compose -f $(DOCKER_COMPOSE_PATH) down 

clean:
	sudo rm -rf $(VOL_DIR)
	docker compose -f $(DOCKER_COMPOSE_PATH) down --rmi all --volumes
re:
	make clean
	make 

$(VOLUME):
	mkdir -p $(VOLUME) 2>/dev/null
