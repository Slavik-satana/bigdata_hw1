# Использование официального образа Python в качестве базового
FROM python:3.11-slim

# Установка рабочей директории
WORKDIR /app

# Установка системных зависимостей, необходимых для psycopg2
RUN apt-get update && apt-get install -y \
    # Установка компилятора GCC
    gcc \
    # Установка библиотек для работы с PostgreSQL
    libpq-dev \
    # Очистка кэша apt для уменьшения размера образа
    && rm -rf /var/lib/apt/lists/*

# Копирование исходного кода приложения
COPY app.py /app

# Установка Python-зависимостей
# Установка библиотек psycopg2, Kafka и Flask
RUN pip install --no-cache-dir psycopg2 kafka-python flask

# Открытие порта Flask-приложения
# Экспонирование порта 5000 для внешнего доступа
EXPOSE 5000

# Указание команды по умолчанию
# Запуск Flask-приложения
CMD ["python", "app.py"]
