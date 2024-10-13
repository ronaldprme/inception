# Color definitions for output
RED 		   = \e[91m
RESET		   = \e[0m

# Docker Compose file path
DOCKER_COMPOSE = ./srcs/docker-compose.yml

# Data paths for volumes
DATA_PATH      = /home/rprocopi/data

# Volume paths
DB_VOLUME      = $(DATA_PATH)/db
WP_VOLUME      = $(DATA_PATH)/wp


# Default target: setup and build the environment
all: setup build

# Setup target: create necessary directories and update hosts file
setup:
	@ sudo mkdir -p $(DB_VOLUME)
	@ sudo mkdir -p $(WP_VOLUME)
	@ sudo sed -i "s/127.0.0.1	localhost/127.0.0.1	rprocopi.42.fr/" /etc/hosts

# Build target: build and start Docker containers
build:
	@ docker-compose -f $(DOCKER_COMPOSE) up --build -d
	@ sudo mkdir -p $(DATA_PATH)
# List containers, images, volumes and network
list:
	@echo "$(RED) -- CONTAINER LIST -- $(RESET)"
	@docker container ls -a
	@echo ""
	@echo "$(RED) -- LIST OF IMAGES -- $(RESET)"
	@docker image ls
	@echo ""
	@echo "$(RED) -- VOLUME LIST -- $(RESET)"
	@docker volume ls
	@echo ""
	@echo "$(RED) -- LIST OF NETWORKS -- $(RESET)"
	@docker network ls

# Inspect for volume details
inspect:
	@echo "$(RED) -- VOLUME DETAILS -- $(RESET)"
	@docker volume inspect mariadb
	@docker volume inspect wordpress

stop:
	@ docker-compose -f $(DOCKER_COMPOSE) down

start:
	@ docker-compose -f $(DOCKER_COMPOSE) up -d

status:
	@echo "$(RED) -- STATUS -- $(RESET)"
	@ docker-compose -f $(DOCKER_COMPOSE) ps -a

volume:
	@ docker volume ls

network:
	@ docker network ls

# Clean target: remove containers, volumes, images, and prune unused resources
clean:
	@if docker image inspect debian:bullseye > /dev/null 2>&1; then \
		echo "Removing debian:bullseye image"; \
		docker image rm debian:bullseye; \
	else \
		echo "skipping removal"; \
	fi
	@docker-compose -f $(DOCKER_COMPOSE) down --volumes
	@docker image prune --force && docker network prune --force
	@docker-compose -f $(DOCKER_COMPOSE) down --rmi all --volumes --remove-orphans

# Full clean target: perform clean and remove data directories
fclean: clean
	@ sudo rm -rf $(DATA_PATH)

# Reset target: stop and remove all Docker containers, images, volumes, and networks
reset:
	@ echo "$(RED) Stopping all containers... $(RESET)"
	@ docker-compose -f $(DOCKER_COMPOSE) down --volumes --remove-orphans
	@ echo "$(RED) Removing all containers... $(RESET)"
	@ docker ps -qa | xargs -r docker rm -f > /dev/null || true
	@ echo "$(RED) Removing all images... $(RESET)"
	@ docker images -qa | xargs -r docker rmi -f > /dev/null || true
	@ echo "$(RED) Removing all volumes... $(RESET)"
	@ docker volume ls -q | xargs -r docker volume rm -f > /dev/null || true
	@ echo "$(RED) Removing all networks... $(RESET)"
	@ docker network ls --filter type=custom --format '{{.ID}}' | xargs -r docker network rm > /dev/null || true

# Rebuild target: perform a full clean and rebuild the environment
re: fclean all

# Declare phony targets
.PHONY: all setup build list inspect clean fclean reset re
