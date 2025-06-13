# Используем официальный образ Python версии 3.10 на базе Debian Buster
FROM python:3.10-slim-buster

# Обновляем список пакетов и устанавливаем build-essential (для компиляции)
# --no-install-recommends предотвращает установку ненужных пакетов
# и уменьшает размер образа.
# rm -rf /var/lib/apt/lists/* очищает кэш пакетов после установки.
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем рабочую директорию внутри контейнера.
# Все последующие команды будут выполняться относительно этой директории.
WORKDIR /app

# Копируем файл requirements.txt из локальной папки в /app в контейнере.
COPY requirements.txt .

# Устанавливаем Python-зависимости, указанные в requirements.txt.
# --no-cache-dir предотвращает создание кэша pip, что уменьшает размер образа.
RUN pip install --no-cache-dir -r requirements.txt

# Копируем все остальные файлы из локальной папки проекта в /app в контейнере.
COPY . .

# Определяем команду, которая будет выполняться при запуске контейнера.
# Это команда, которая запустит вашего бота.
CMD ["python", "webapp_bot_aiogram3_fixed.py"]
