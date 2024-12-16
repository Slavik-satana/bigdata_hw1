# Используем базовый образ
FROM timmyalvice8/pyspark-consumer:latest

# Копируем файл app.py из текущей директории в директорию app внутри контейнера
COPY app.py /app/app.py

# Остальные настройки и команды остаются без изменений