# Social Network

Facebook-like social network built with Go microservices and a Vue 3 frontend. Uses a shared SQLite database and WebSockets for real-time features.

## Prerequisites (recommended path)

- Docker Desktop / Docker Engine
- Docker Compose v2 (`docker compose`)

## Quick start (Docker)

1) Clone and enter the repo
```bash
git clone <repository-url>
cd social-network
```

2) Frontend env config (required)
```bash
copy frontend\.env.example frontend\.env
```
On macOS/Linux:
```bash
cp frontend/.env.example frontend/.env
```
Note: This repo includes the env files only because it's a student exercise/project. In production, these files should not be committed.

3) Start the stack
```bash
docker compose up --build
```

This runs a one-off `migrate` container first (built from `db/migrate.Dockerfile` with SQLite support), then starts all services.
If your Compose version does not support `depends_on` conditions, run:
```bash
docker compose run --rm migrate
docker compose up --build
```

4) Open the app
- Frontend: http://localhost:3000

## Database & migrations

- Database file: `db/social_network.db` (created automatically on first run).
- To reset the DB: stop containers and delete `db/social_network.db`, then start again.

## Ports

- Auth: http://localhost:8081
- Users: http://localhost:8082
- Posts: http://localhost:8083
- Groups: http://localhost:8084
- Chat: http://localhost:8085
- Notifications: http://localhost:8086
- Frontend: http://localhost:3000

Note: In a production setup, I wouldn't expose all service ports directly. I list them here because this is a student project 

## Stop the stack

```bash
docker compose down
```

If you see leftover containers:
```bash
docker compose down --remove-orphans
```
