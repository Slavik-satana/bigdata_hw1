# Используем базовый образ с установленной Java
# Легковесный образ с Java 11, необходимый для работы Apache Spark
FROM openjdk:11-slim

# Устанавливаем Python и другие необходимые пакеты
# Обновляем список пакетов и устанавливаем минимальный набор
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Устанавливаем Python 3
    python3 \ 
    # Устанавливаем менеджер пакетов pip
    python3-pip \ 
    # Устанавливаем инструменты сборки (необходимы для некоторых зависимостей)
    build-essential \ 
    # Удаляем кэш apt, чтобы уменьшить размер образа
    && rm -rf /var/lib/apt/lists/* 

# Указываем рабочую директорию
# Все дальнейшие команды будут выполняться из каталога /app
WORKDIR /app  

# Устанавливаем curl, загружаем ClickHouse JDBC-драйвер, удаляем временные файлы
# Устанавливаем curl для загрузки драйвера
RUN apt-get update && apt-get install -y curl && \
    # Скачиваем ClickHouse JDBC-драйвер в рабочую директорию
    curl -fL -o /app/clickhouse-jdbc-0.4.6-all.jar \ 
    # Указываем URL драйвера
    https://repo1.maven.org/maven2/com/clickhouse/clickhouse-jdbc/0.4.6/clickhouse-jdbc-0.4.6-all.jar && \ 
    # Удаляем curl и связанные с ним временные файлы
    apt-get remove -y curl && apt-get autoremove -y && \ 
    # Очищаем кэш apt, чтобы уменьшить размер образа
    rm -rf /var/lib/apt/lists/*

# Копируем файл приложения в контейнер
# Копируем локальный файл app.py в рабочую директорию контейнера
COPY app.py /app/ 

# Устанавливаем зависимости для Python
# Устанавливаем библиотеки PySpark и ClickHouse Python драйвер
RUN pip3 install pyspark clickhouse-driver

# Устанавливаем переменные окружения
# Указываем Python не буферизовать вывод (полезно для логирования)
ENV PYTHONUNBUFFERED=1

# Запускаем приложение через spark-submit
CMD ["spark-submit", \
    "--packages", \
    "org.apache.spark:spark-sql-kafka-0-10_2.12:3.4.0", \
    "--jars", \
    "/app/clickhouse-jdbc-0.4.6-all.jar", \
    "/app/app.py"]  

# Используем spark-submit для запуска app.py
# --packages: подключаем библиотеку Kafka для Spark
# --jars: указываем путь к драйверу ClickHouse JDBC
