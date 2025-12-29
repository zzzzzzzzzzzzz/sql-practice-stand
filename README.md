# sql-practice-stand

## Schema

See [docs/schema.md](docs/schema.md) for the entity-relationship diagram and notes about how the PostgreSQL seed script aligns with it.

## Local tooling

A `docker-compose.yml` is available to bring up a PostgreSQL instance alongside Adminer and a Traefik reverse proxy (for future domain and TLS support):

```bash
docker compose up -d
```

Environment variables (with sensible defaults) can be supplied via a `.env` file or directly in the shell/CI environment. Update the defaults before exposing services to the internet.

| Variable | Default | Purpose |
| --- | --- | --- |
| `POSTGRES_USER` | `practice_user` | Database user |
| `POSTGRES_PASSWORD` | `practice_password` | Database password |
| `POSTGRES_DB` | `practice_db` | Database name |
| `POSTGRES_PORT` | `5432` | Host port for PostgreSQL |
| `ADMINER_DEFAULT_SERVER` | `postgres` | Adminer default server |
| `ADMINER_PORT` | `8080` | Host port for Adminer (direct access) |
| `BASE_DOMAIN` | `sql.practice.zzzzzzzzzzzzz.cc` | Base domain used for Traefik host rules |
| `TRAEFIK_ACME_EMAIL` | `you@example.com` | Email used for ACME/Let’s Encrypt |
| `TRAEFIK_BASIC_AUTH_USERS` | `admin:<hashed password>` | Basic auth users for Adminer (Traefik middleware) |

For GitHub Actions, you can pass the same variables in a workflow using `env:` plus encrypted secrets:

```yaml
jobs:
  db:
    runs-on: ubuntu-latest
    env:
      POSTGRES_USER: ${{ secrets.POSTGRES_USER }}
      POSTGRES_PASSWORD: ${{ secrets.POSTGRES_PASSWORD }}
      POSTGRES_DB: practice_db
      POSTGRES_PORT: 5432
      ADMINER_PORT: 8080
      BASE_DOMAIN: sql.practice.zzzzzzzzzzzzz.cc
      TRAEFIK_ACME_EMAIL: ${{ secrets.TRAEFIK_ACME_EMAIL }}
      TRAEFIK_BASIC_AUTH_USERS: ${{ secrets.TRAEFIK_BASIC_AUTH_USERS }}
    steps:
      - uses: actions/checkout@v4
      - run: docker compose up -d
```

## Deployment via GitHub Actions

Automated deployment to a remote host is handled by `.github/workflows/deploy.yml`. The workflow syncs the repository to your server over SSH, writes a `.env` file from your secrets (aligning with the variables in `docker-compose.yml`), and runs `docker compose pull` followed by `docker compose up -d --remove-orphans`.

Requirements for the target host:
- SSH access with a private key stored as a secret.
- Docker Engine with the Compose plugin installed.
- DNS for `BASE_DOMAIN` (and `adminer.<BASE_DOMAIN>`) pointing at the host if you want Traefik/ACME to succeed.

Triggers:
- Pushes to `main`.
- Manual runs via **Run workflow**.

Required GitHub secrets:

| Secret | Purpose |
| --- | --- |
| `DEPLOY_HOST` | SSH host or IP for the deployment target |
| `DEPLOY_USER` | SSH user |
| `DEPLOY_PATH` | Remote directory to sync the project into |
| `DEPLOY_SSH_KEY` | Private key with access to the host |
| `BASE_DOMAIN` | Base domain for Traefik host rules |
| `TRAEFIK_ACME_EMAIL` | ACME/Let’s Encrypt email |
| `TRAEFIK_BASIC_AUTH_USERS` | Basic auth users for Adminer |
| `POSTGRES_USER` | Database user |
| `POSTGRES_PASSWORD` | Database password |

Optional secrets (these have defaults in the workflow if omitted):

| Secret | Default | Purpose |
| --- | --- | --- |
| `DEPLOY_SSH_PORT` | `22` | SSH port |
| `POSTGRES_DB` | `practice_db` | Database name |
| `POSTGRES_PORT` | `5432` | Host port for PostgreSQL |
| `ADMINER_PORT` | `8080` | Host port for Adminer |

### Notes on Traefik and Adminer authentication

- Traefik listens on ports 80/443 and routes `adminer.<BASE_DOMAIN>` to Adminer. Update DNS to point `adminer.<BASE_DOMAIN>` at your host before enabling TLS/Let’s Encrypt.
- Replace the default `TRAEFIK_BASIC_AUTH_USERS` value (which is a hashed `admin:admin` pair) with a secure hash. You can generate one with `htpasswd -nb <user> <password>` and place it in `.env` or a secret.
- If you prefer to avoid exposing Adminer publicly, omit the Traefik labels in `docker-compose.yml` and rely on `ADMINER_PORT` for local-only access (e.g., by binding the port to `127.0.0.1:8080:8080`).
