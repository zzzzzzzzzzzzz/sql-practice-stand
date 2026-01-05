# sql-practice-stand

## Schema

See [docs/schema.md](docs/schema.md) for the entity-relationship diagram and notes about how the PostgreSQL seed script aligns with it.

## Local tooling

A `docker-compose.yml` is available to bring up a PostgreSQL instance alongside Adminer and a Traefik reverse proxy (for future domain and TLS support). The shared network is explicitly named `traefik-public` so Traefik’s Docker provider and per-service labels resolve to the same network when the project name is auto-prefixed by Compose:

```bash
docker compose up -d
```

**Traefik HTTPS/ACME:** Ensure TCP/80 and TCP/443 are reachable from the internet for `BASE_DOMAIN` (and `adminer.<BASE_DOMAIN>`). Traefik’s HTTP challenge (`letsencrypt` resolver) is enabled in `docker-compose.yml`; certificate issuance will fail—and browsers will show an invalid/self-signed cert—if DNS is not pointing at the host or if port 80 is blocked.

**Traefik basic auth tip:** Traefik expects `TRAEFIK_BASIC_AUTH_USERS` in `username:hash` format (the hash from `htpasswd -nb <user> <password>`). If you see log errors like `error parsing BasicUser: $apr1$...`, add the username prefix and keep the value quoted in `.env` so `$` is not mangled, e.g.:
```bash
TRAEFIK_BASIC_AUTH_USERS="admin:$$apr1$$x2k87nhN$$MIU0oc3VeZfdT/oFbgsno1"
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

The deploy job is bound to the `main` GitHub environment, so configure these secrets in the **Environment secrets** for `main` (or in org-level environment secrets). This also lets you enforce any environment protections (approvals, branch rules, etc.) you’ve configured on `main`.

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

### Acquiring `DEPLOY_SSH_KEY`

Use a dedicated SSH key for GitHub Actions deployments (avoid reusing a personal key):

1. Generate a new key on your workstation without a passphrase:
   ```bash
   ssh-keygen -t ed25519 -f deploy_key -C "sql-practice-stand deploy"
   ```
2. Copy the public key to your server (adjust port/user/host as needed):
   ```bash
   ssh-copy-id -i deploy_key.pub -p 22 your-user@your-host
   ```
   Alternatively, append the contents of `deploy_key.pub` to `~/.ssh/authorized_keys` on the server.
3. Add the private key contents to the `DEPLOY_SSH_KEY` secret in your GitHub repository settings. Paste the full contents of `deploy_key` (including the `BEGIN/END OPENSSH PRIVATE KEY` lines).
4. Delete the private key from your local filesystem if you do not need it elsewhere, or store it securely in a password manager; the public key can remain on the server.

### Notes on Traefik and Adminer authentication

- Traefik listens on ports 80/443 and routes `adminer.<BASE_DOMAIN>` to Adminer. Update DNS to point `adminer.<BASE_DOMAIN>` at your host before enabling TLS/Let’s Encrypt.
- Replace the default `TRAEFIK_BASIC_AUTH_USERS` value (which is a hashed `admin:admin` pair) with a secure hash. You can generate one with `htpasswd -nb <user> <password>` and place it in `.env` or a secret.
- If you prefer to avoid exposing Adminer publicly, omit the Traefik labels in `docker-compose.yml` and rely on `ADMINER_PORT` for local-only access (e.g., by binding the port to `127.0.0.1:8080:8080`).

### Sizing guidance for a small, containerized deployment

This stack is lightweight (PostgreSQL + Adminer + Traefik) and will comfortably serve a single developer or a small team (up to ~10 concurrent users) on modest hardware:

- **CPU:** 2 vCPUs is sufficient; 4 vCPUs provides headroom for maintenance tasks (backups, vacuuming) without noticeable contention.
- **Memory:** 4 GB RAM works for a lightly used database; 8 GB improves caching and responsiveness under bursty workloads.
- **Disk:** Start with 20–40 GB of fast SSD-backed storage. Leave room for WAL growth and backups; consider separate volumes for the database data directory and backups if available.
- **Network:** A stable connection with low latency is more important than high bandwidth; typical cloud egress/ingress is ample for SQL and Adminer usage.
- **Platform:** A small cloud VM (e.g., 2 vCPU / 4–8 GB RAM) running Docker Engine with the Compose plugin is adequate. Avoid oversubscribing the host if you co-locate other containers.
- **Operating system:** A stable Linux LTS distro with good Docker support (e.g., Ubuntu LTS, Debian stable, or Rocky/AlmaLinux) is preferred. Use a minimal install, keep the kernel updated, and avoid mixing distro package Docker with upstream Docker Engine packages.

Monitor container CPU, memory, and disk usage initially; if sustained utilization regularly exceeds ~70%, scale the VM up one size (more vCPU/RAM) or move PostgreSQL to a managed service.
