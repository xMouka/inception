*This project has been created as part of the 42 curriculum by fbalyout.*

## Description
Inception is a Docker-based infrastructure project.
It runs a secure WordPress stack with NGINX (TLS), WordPress + PHP-FPM, and MariaDB.
Bonus services include Redis cache, FTP access, a static website, Adminer, and a backup service.

### Project description
- Docker is used to isolate each service in its own container.
- Each service is built from a custom Dockerfile.
- Secrets are injected at runtime through Docker secrets.

### Design choices
- Virtual Machines vs Docker: Docker is lighter and faster to start, with service-level isolation.
- Secrets vs Environment Variables: secrets are used for passwords; env vars are used for non-sensitive configuration.
- Docker Network vs Host Network: bridge network is used to isolate and connect internal services.
- Docker Volumes vs Bind Mounts: named volumes are used for WordPress and MariaDB persistence under `/home/fbalyout/data`.

## Instructions
- Build and start: `make`
- Stop: `make down`
- Rebuild: `make re`
- Clean data: `make clean`

## Resources
- Docker docs: https://docs.docker.com/
- Docker Compose docs: https://docs.docker.com/compose/
- NGINX docs: https://nginx.org/en/docs/
- MariaDB docs: https://mariadb.com/kb/en/documentation/
- WordPress docs: https://developer.wordpress.org/

### AI usage
AI was used to speed up repetitive tasks, review configuration consistency, and help draft/refine scripts.
All generated content was reviewed, tested, and adapted before use.
