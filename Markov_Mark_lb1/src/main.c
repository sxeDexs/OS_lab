#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Ошибка: укажите путь к файлу в качестве аргумента.\n");
        return EXIT_FAILURE;
    }

    const char *filePath = argv[1];

    // Попытка открыть файл для чтения
    FILE *file = fopen(filePath, "r");
    if (file == NULL) {
        perror("Не удалось открыть файл");
        return EXIT_FAILURE;
    }

    // Буфер для чтения строк из файла
    char line[512]; // Увеличим размер буфера для более длинных строк
    while (fgets(line, sizeof(line), file)) {
        // Выводим строку на экран
        printf("%s", line);
    }

    // Закрываем файл
    fclose(file);

    return EXIT_SUCCESS;
}
