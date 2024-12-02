name = inception

all: build start
	@echo "Launch configuration ${name}...\n"

start:
	@echo "Starting container for ${name}....\n"
	@bash srcs/requirements/wordpress/tools/make_dir.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d

build:
	@printf "Building configuration ${name}...\n"
	@bash srcs/requirements/wordpress/tools/make_dir.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env build

down:
	@printf "Stopping configuration ${name}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env down

re: fclean build start
	@printf "Rebuild configuration ${name}...\n"

clean: down
	@printf "Cleaning configuration ${name}...\n"
	@docker-compose -f ./srcs/docker-comopse.yml --env-file srcs/.env down --volumes --remove-orphans
	@sudo rm -rf ~/data/wordpress
	@sudo rm -rf ~/data/mariadb

fclean:
	@printf "Total clean of all configurations docker\n"
	@docker-compose -f ./srcs/docker-comopse.yml --env-file srcs/.env down --volumes --remove-orphans
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@sudo rm -rf ~/data/wordpress
	@sudo rm -rf ~/data/mariadb

.PHONY	: all build down re clean fclean start
