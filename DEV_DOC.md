# DEV_DOC

## Prerequisites
- Linux environment
- Docker and Docker Compose plugin installed
- Domain `fbalyout.42.fr` mapped to local machine IP

## Setup from scratch
1. Create secrets in `secrets/`.
2. Ensure `.env` is configured in `srcs/.env`.
3. Run `make` from project root.

## Build and launch
- `make` runs Docker Compose build + up.
- Compose file: `srcs/docker-compose.yml`.
- Dockerfiles are in `srcs/requirements/*/Dockerfile`.

## Useful commands
- Status: `docker compose -f srcs/docker-compose.yml ps`
- Logs: `docker compose -f srcs/docker-compose.yml logs -f <service>`
- Recreate one service: `docker compose -f srcs/docker-compose.yml up -d --build <service>`
- Shell in container: `docker compose -f srcs/docker-compose.yml exec <service> sh`

## Data persistence
- WordPress files volume: `/home/fbalyout/data/wordpress`
- MariaDB data volume: `/home/fbalyout/data/mariadb`
- Backup artifacts: `srcs/backups/`
