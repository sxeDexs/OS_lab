#!/bin/bash

# Проверяем, был ли передан аргумент с файлом для вывода и путь к целевому файлу
if [ "$#" -ne 2 ]; then
    echo "Использование: $0 <путь к файлу> <путь к выходному файлу>"
    exit 1
fi

# Путь к исходному файлу и выходной файл
target_file="$1"
output_file="$2"

# Проверка, существует ли файл
if [ ! -e "$target_file" ]; then
    echo "Файл '$target_file' не существует."
    exit 1
fi

# Получаем inode целевого файла с помощью stat
inode=$(stat -c %i "$target_file")

# Проверка на пустой inode
if [ -z "$inode" ]; then
    echo "Не удалось получить inode для файла '$target_file'."
    exit 1
fi

# Очищаем или создаем файл для вывода
> "$output_file"

# Выводим информацию о нужной ссылке
echo "Ищем жесткие ссылки для файла: $target_file с inode: $inode"

# Рекурсивно ищем файлы с таким же inode
ls -iR / 2>/dev/null | grep "$inode" | awk '{print "Жесткая ссылка: " $2}' >> "$output_file"

# Выводим результат в консоль
echo "Поиск завершен. Результаты записаны в файл: $output_file"


