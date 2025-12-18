#!/bin/bash

echo "=== Загрузка веб-логов в ElasticSearch ==="

# Ждем запуска ElasticSearch
echo "Ожидание запуска ElasticSearch..."
sleep 30

# Запускаем Logstash для обработки данных
echo "Запуск Logstash pipeline..."
docker compose exec -d logstash logstash -f /usr/share/logstash/pipeline/clickstream.conf --config.reload.automatic

# Даем время на обработку
echo "Обработка данных..."
sleep 15

# Проверяем индексы
echo "Проверяем созданные индексы..."
curl -s "http://localhost:9200/_cat/indices?v" | grep -E "health|index|web-logs"

# Проверяем количество документов
echo "Количество документов:"
curl -s "http://localhost:9200/web-logs-*/_count?pretty"

echo "=== Готово! ==="
echo "Kibana доступен по адресу: http://localhost:5601"
echo "ElasticSearch: http://localhost:9200"
