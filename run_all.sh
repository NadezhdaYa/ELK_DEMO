#!/bin/bash

echo "=== ELK Stack для анализа веб-логов ==="
echo "Автор: [Ваше имя]"
echo "Дата: $(date)"
echo ""

# 1. Останавливаем старые контейнеры
echo "1. Очистка старых контейнеров..."
docker compose down -v 2>/dev/null

# 2. Запускаем контейнеры
echo "2. Запуск ELK стека..."
docker compose up -d

# 3. Ждем запуска
echo "3. Ожидание запуска сервисов (60 секунд)..."
sleep 60

# 4. Проверяем сервисы
echo "4. Проверка сервисов:"
echo "   - ElasticSearch: $(curl -s -o /dev/null -w "%{http_code}" http://localhost:9200/)"
echo "   - Kibana: $(curl -s -o /dev/null -w "%{http_code}" http://localhost:5601/)"

# 5. Запускаем загрузку данных
echo "5. Загрузка данных..."
./load_data.sh

echo ""
echo "=== ИНСТРУКЦИЯ ==="
echo "1. Откройте Kibana: http://localhost:5601"
echo "2. Создайте Data View для индекса: web-logs-*"
echo "3. Time field: @timestamp"
echo "4. Создайте дашборд с визуализацией status_code по времени"
