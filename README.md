# Local PHP Multi-Version & Service Development Environment

This project provides a local Docker environment designed for developing and testing PHP applications (supporting PHP 7.2, 8.1, and 8.2), combined with essential service containers (MySQL 5.7, MySQL 8.0, Elasticsearch 8, Redis, RabbitMQ, and MailCatcher).

---

## Repository Structure

* **`docker-compose.yml`** — Main configuration file for all containers and networks.
* **`Makefile`** — Shortcut commands for managing the stack.
* **`www/`** — Working directory containing individual web projects and applications.
* **`nginx/conf.d/`** — Configuration files for the Nginx web server.
* **`mysql/`** — Configuration files for the databases.
* **`php/`** — Custom `local.ini` settings for PHP.

---

## Prerequisites

Ensure you have the following installed on your machine:
* Docker
* Docker Compose

---

## Quick Start

1. **Environment Configuration:**
   If you don't have a `.env` file yet, create one from the example template using the Makefile:
   **`make env`**

2. **Starting the Environment:**
   Depending on the project you are testing, you can launch the appropriate PHP stack alongside databases and helper services:
   * For **PHP 8.2 + MySQL 8 + Redis + Mailer**: **`make up-82-8`**
   * For **PHP 8.1 + MySQL 8**: **`make up-81-8`**
   * For **PHP 7.2 + MySQL 5**: **`make up-72-5`**

3. **Stopping the Environment:**
   **`make down`**

---

## Installing Dependencies (Composer)

Since Composer runs inside an isolated container, use the following Docker command directly in your terminal to install dependencies for a specific project (e.g., located in `www/L37sg0`):

```bash
docker run --rm -v $(pwd)/www:/var/www -w /var/www/L37sg0 composer:latest install
```

---

## Useful Makefile Commands

* **Check container status:** **`make ps`**
* **View container logs:** **`make logs`**
* **Quick database CLI access:**
  * For MySQL 8: **`make db8`**
  * For MySQL 5: **`make db5`**
* **Access PHP container terminals (Bash):**
  * **`make php82`**
  * **`make php81`**
  * **`make php72`**