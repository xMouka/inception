# USER_DOC

## Provided services
- NGINX on HTTPS (443)
- WordPress + PHP-FPM
- MariaDB
- Redis cache
- FTP for WordPress volume
- Static site
- Adminer
- Backup service

## Start and stop
- Start all services: `make`
- Stop all services: `make down`
- Rebuild: `make re`

## Access
- WordPress: `https://fbalyout.42.fr`
- Static site: `http://localhost:8080`
- Adminer: `http://localhost:8081`
- FTP: port `21` and passive ports `40000-40010`

## Credentials
- Stored in `secrets/`
- Database user password: `secrets/db_password.txt`
- Database root password: `secrets/db_root_password.txt`
- WordPress admin password: `secrets/credentials.txt`
- WordPress user password: `secrets/wp_user_password.txt`
- FTP password: `secrets/ftp_pass.txt`

## Health checks
- `docker compose -f srcs/docker-compose.yml ps`
- `docker compose -f srcs/docker-compose.yml logs <service>`
- Backups are in `srcs/backups/`
