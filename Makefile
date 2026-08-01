-include .env
export

.PHONY: env build up down restart logs ps composer php72 php81 php82 db8 db5 up-service

# Автоматично създаване на .env от .env.example при липса
env:
ifeq (,$(wildcard .env))
	@if [ -f .env.example ]; then \
		cp .env.example .env; \
		echo "Created .env file from .env.example"; \
	else \
		echo "Error: .env.example file not found!"; \
		exit 1; \
	fi
else
	@echo ".env file already exists."
endif

# Основни команди за Docker (преди 'up' проверява за .env)
build: env
	docker-compose build

# Стандартно пускане на всичко (ако все пак ти трябва)
up: env
	docker-compose up -d

# Универсално пускане на конкретен услугов контейнер
# Пример: make up-service elastic8
# Пример: make up-service rabbitmq
# Пример: make up-service redis
up-service: env
	docker-compose up -d $(filter-out $@,$(MAKECMDGOALS))

# Интелигентно пускане само на това, което ти трябва:
# Пример: make up-82-8 (пуска php82, mysql8, web и базови услуги като redis/mailer)
up-72-5: env
	docker-compose up -d web php72 mysql5 redis mailer

up-81-8: env
	docker-compose up -d web php81 mysql8 redis mailer

up-82-8: env
	docker-compose up -d web php82 mysql8 redis mailer

# Само уеб с конкретна PHP версия и без излишни бази (ако ползваш външна или sqlite)
up-82-only: env
	docker-compose up -d web php82

down:
	docker-compose down

restart: down up

logs:
	docker-compose logs -f

ps:
	docker-compose ps

# Composer команда (напр. make composer install)
composer:
	docker-compose run --rm composer $(filter-out $@,$(MAKECMDGOALS))

# Влизане в контейнерите за съответната PHP версия
php72:
	docker-compose exec php72 bash

php81:
	docker-compose exec php81 bash

php82:
	docker-compose exec php82 bash

# Бърз достъп до базата данни през CLI
db8:
	docker-compose exec mysql8 mysql -u${DB_USERNAME} -p${DB_PASSWORD} ${DB_DATABASE}

db5:
	docker-compose exec mysql5 mysql -u${DB_USERNAME} -p${DB_PASSWORD} ${DB_DATABASE}

# Хващане на аргументи за composer, за да не гърми Makefile-а
%:
	@: