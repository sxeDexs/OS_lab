#!/bin/bash

# Путь к каталогу
dir_path="/tmp/test_directory"

# Проверка, был ли передан путь
if [ -z "$1" ]; then
    echo "Укажите путь к каталогу для эксперимента."
    exit 1
fi

# Устанавливаем путь к каталогу
dir_path="$1"

# Проверка, существует ли каталог
if [ ! -d "$dir_path" ]; then
    echo "Каталог '$dir_path' не существует. Создаем каталог."
    mkdir -p "$dir_path"
fi

# Функция для проверки размера каталога
check_size() {
    echo "Размер каталога '$dir_path':"
    du -sh "$dir_path"
}

# Начальный размер каталога
echo "Начальный размер каталога:"
check_size

# Создаем файлы в каталоге
echo "Добавляем файлы в каталог..."
for i in {1..1000}; do
    touch "$dir_path/file$i"
done
check_size

# Создаем подкаталог
echo "Создаем подкаталог..."
mkdir "$dir_path/subdir"
check_size

# Удаляем файлы
echo "Удаляем файлы из каталога..."
rm "$dir_path/file"{1..1000}
check_size

# Удаляем подкаталог
echo "Удаляем подкаталог..."
rm -r "$dir_path/subdir"
check_size

# Заключение
echo "Эксперимент завершен."

