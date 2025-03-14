#!/bin/bash

# Проверяем, был ли передан аргумент с файлом для вывода
if [ -z "$1" ]; then
    echo "Укажите файл для записи вывода."
    exit 1
fi

# Файл для вывода
output_file="$1"

# Очищаем или создаем файл вывода
> "$output_file"

# Обработаем обычные файлы
ls -lR / 2>/dev/null | grep -m 1 "^-" | awk '{print "Обычный файл: " $NF}' >> "$output_file"

# Обработаем блочные устройства
ls -lR / 2>/dev/null | grep -m 1 "^b" | awk '{print "Блочное устройство: " $NF}' >> "$output_file"

# Обработаем символьные устройства
ls -lR / 2>/dev/null | grep -m 1 "^c" | awk '{print "Символьное устройство: " $NF}' >> "$output_file"

# Обработаем директории
ls -lR / 2>/dev/null | grep -m 1 "^d" | awk '{print "Директория: " $NF}' >> "$output_file"

# Обработаем символьные ссылки
ls -lR / 2>/dev/null | grep -m 1 "^l" | awk '{print "Символьная ссылка: " $NF}' >> "$output_file"

# Обработаем FIFO
ls -lR / 2>/dev/null | grep -m 1 "^p" | awk '{print "FIFO: " $NF}' >> "$output_file"

# Обработаем сокеты
ls -lR / 2>/dev/null | grep -m 1 "^s" | awk '{print "Сокет: " $NF}' >> "$output_file"

echo "Поиск завершен. Результаты записаны в файл: $output_file"

