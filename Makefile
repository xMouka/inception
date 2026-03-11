all:
	mkdir -p /home/mouka/data/mariadb
	mkdir -p /home/mouka/data/wordpress
	docker compose -f srcs/docker-compose.yml up -d --build

down:
	docker compose -f srcs/docker-compose.yml down

re: down all

clean: down
	docker system prune -af
	rm -rf /home/mouka/data/mariadb
	rm -rf /home/mouka/data/wordpress