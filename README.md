Repository containing recipe for sqlx-cli docker image published to Docker Hub.
I'm using nix dockerTools to make resulting image as small as possible.

I've made this image to have recent version of sqlx-cli to run migrations with docker compose instead of putting them in my app, which seems like much better workflow.

It's just sqlx-cli packaged into container, so you can refer to https://github.com/launchbadge/sqlx/tree/main/sqlx-cli for additional documentation.

# Usage

## With docker
```bash
  docker run -v ./migrations:/migrations nxyt/sqlx-cli:latest migrate run --database-url=postgres://postgres:dev@172.17.0.1:5432/postgres
```

## With docker compose
```yaml
  migrate:
    image: nxyt/sqlx-cli
    # optional if you want to wait till database containers is ready to accept connections 
    # depends_on:
    #   db:
    #     condition: service_healthy
    command: migrate run
    volumes:
      - ./migrations:/migrations
    environment:
      - DATABASE_URL=postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@db:${POSTGRES_PORT}/${POSTGRES_DB}?sslmode=disable  
``` 

# Build image locally

## Prerequisites
```bash
  nix
  docker
```

## Commands
```bash
  nix build .
  docker load -i result
  # image is available as sqlx-cli:latest
```