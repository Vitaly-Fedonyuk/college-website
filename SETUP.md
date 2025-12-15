# Інструкція з налаштування / Setup Guide

## Швидкий старт з Docker

### Крок 1: Встановіть необхідне ПЗ

Переконайтеся, що у вас встановлено:
- Docker Desktop або Docker Engine
- Git

### Крок 2: Клонуйте репозиторій

```bash
git clone https://github.com/Vitaly-Fedonyuk/college-website.git
cd college-website
```

### Крок 3: Створіть файл .env

```bash
cp .env.example .env
```

Відредагуйте `.env` файл та встановіть необхідні змінні:

```env
# Базові налаштування БД
POSTGRES_USER=postgres
POSTGRES_PASSWORD=your_secure_password
POSTGRES_DB=college_website_development

# Rails
RAILS_MASTER_KEY=your_master_key_here

# AWS S3 (опціонально для локальної розробки)
AWS_ACCESS_KEY_ID=your_aws_key
AWS_SECRET_ACCESS_KEY=your_aws_secret
AWS_REGION=us-east-1
AWS_BUCKET=your_bucket_name
```

### Крок 4: Запустіть Docker Compose

```bash
# Побудова контейнерів
docker compose build

# Запуск сервісів
docker compose up -d

# Створення бази даних
docker compose exec web rails db:create

# Виконання міграцій
docker compose exec web rails db:migrate

# Завантаження тестових даних
docker compose exec web rails db:seed
```

### Крок 5: Відкрийте додаток

Перейдіть за адресою: http://localhost:3000

## Локальна розробка без Docker

### Вимоги

- Ruby 3.2.3
- PostgreSQL 15+
- Redis 7+
- Node.js 20+
- Yarn 1.22+

### Крок 1: Встановіть залежності

```bash
# Ruby gems
bundle install

# Node.js packages
yarn install
```

### Крок 2: Налаштуйте PostgreSQL

Створіть користувача PostgreSQL:

```bash
sudo -u postgres createuser -s your_username
```

Або використовуйте наявного користувача, оновивши `config/database.yml`

### Крок 3: Створіть базу даних

```bash
rails db:create
rails db:migrate
rails db:seed
```

### Крок 4: Запустіть сервери

Опція A - Використання Foreman (рекомендовано):

```bash
gem install foreman
foreman start -f Procfile.dev
```

Опція B - Окремі термінали:

Термінал 1 - Rails сервер:
```bash
rails server
```

Термінал 2 - CSS компіляція:
```bash
yarn build:css --watch
```

Термінал 3 - Redis (якщо потрібно для Action Cable):
```bash
redis-server
```

### Крок 5: Відкрийте додаток

Перейдіть за адресою: http://localhost:3000

## Додавання тестових новин

Після запуску додатку ви можете додати власні новини через Rails console:

```bash
# Для Docker
docker compose exec web rails console

# Для локальної розробки
rails console
```

В консолі:

```ruby
News.create!(
  title: "Тестова новина",
  content: "Це тестова новина для перевірки функціоналу.",
  published_at: Time.current
)
```

## Налаштування AWS S3 (Production)

### 1. Створіть S3 Bucket

1. Увійдіть в AWS Console
2. Перейдіть до S3
3. Створіть новий bucket з унікальною назвою
4. Налаштуйте CORS policy

### 2. Створіть IAM користувача

1. Перейдіть до IAM
2. Створіть нового користувача
3. Надайте права `AmazonS3FullAccess`
4. Згенеруйте Access Key

### 3. Додайте credentials

Для production оновіть змінні середовища:

```bash
AWS_ACCESS_KEY_ID=your_access_key
AWS_SECRET_ACCESS_KEY=your_secret_key
AWS_REGION=us-east-1
AWS_BUCKET=your-bucket-name
```

## Корисні команди

### Docker Compose

```bash
# Перегляд логів
docker compose logs -f web

# Зупинка сервісів
docker compose down

# Перезапуск
docker compose restart

# Вхід в контейнер
docker compose exec web bash

# Rails console
docker compose exec web rails console

# Виконання міграцій
docker compose exec web rails db:migrate
```

### Rails

```bash
# Створення міграції
rails generate migration CreateTableName

# Rollback останньої міграції
rails db:rollback

# Перегляд маршрутів
rails routes

# Rails console
rails console

# Перегляд версії
rails --version
```

## Виправлення проблем

### Проблема: Конфлікт портів (Port already allocated)

Якщо ви отримуєте помилку `Bind for 0.0.0.0:5432 failed: port is already allocated`, це означає що порт вже використовується іншим сервісом.

**Рішення:** Docker Compose використовує внутрішню мережу, тому порти PostgreSQL та Redis НЕ виставлені назовні за замовчуванням. Це запобігає конфліктам з локальними сервісами.

Якщо вам потрібен прямий доступ до бази даних:

```bash
# Підключення до PostgreSQL через Docker
docker compose exec db psql -U postgres -d college_website_development

# Або експортуйте порт тимчасово (додайте в docker-compose.yml під db:)
# ports:
#   - "5433:5432"  # Використовуйте інший порт (5433) щоб уникнути конфлікту
```

### Проблема: Помилка підключення до бази даних

**Рішення:** Переконайтеся, що PostgreSQL запущено:

```bash
# Docker
docker compose up db

# Локально
sudo service postgresql start
```

### Проблема: Assets не компілюються

**Рішення:** Видаліть старі assets та перекомпілюйте:

```bash
rm -rf public/assets
rm -rf app/assets/builds/*
yarn build:css
rails assets:precompile
```

### Проблема: Bundler помилки

**Рішення:** Оновіть bundler:

```bash
gem update bundler
bundle install
```

## Deployment на Production

Дивіться детальні інструкції в основному README.md файлі.

## Підтримка

Якщо виникли питання або проблеми:
1. Перевірте логи: `docker compose logs -f` або `tail -f log/development.log`
2. Створіть issue на GitHub
3. Перевірте документацію Rails: https://guides.rubyonrails.org/
