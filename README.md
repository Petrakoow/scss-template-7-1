# scss-template-7-1-v1

**Простой скрипт для быстрой реализации паттерна 7-1 с препроцессором SCSS.**

Этот скрипт создает необходимые директории и базовые partial-файлы для вашего SCSS проекта, импортирует их в `main.scss` и опционально добавляет стили сброса в файл `_reset.scss`.

## Инструкции по установке

1. **Монтирование скрипта:**

   - Скопируйте скрипт и опционально файл стилей сброса в директорию `/usr/local/bin`:
     ```bash
     cp create-scss-pattern-7-1.sh /usr/local/bin/
     cp reset-styles.css /usr/local/bin/  # Опционально
     ```

   - Дайте скрипту права на выполнение:
     ```bash
     chmod +x /usr/local/bin/create-scss-pattern-7-1.sh
     ```

2. **Запуск скрипта:**

   - Откройте терминал (WSL или Unix оболочку) и перейдите в директорию вашего проекта:
     ```bash
     cd /путь/к/вашему/проекту
     ```

   - Выполните скрипт:
     ```bash
     /usr/local/bin/create-scss-pattern-7-1.sh
     ```

   - Скрипт создаст следующую структуру в вашей директории проекта:
     ```
     scss/
     ├── abstracts/
     │   ├── _variables.scss
     │   ├── _functions.scss
     │   └── _mixins.scss
     ├── base/
     │   ├── _reset.scss
     │   └── _typography.scss
     ├── components/
     ├── layout/
     ├── pages/
     ├── themes/
     └── vendors/
     ```

   - Файл `main.scss` будет включать необходимые импорты:
     ```scss
     @import 'abstracts/variables';
     @import 'abstracts/functions';
     @import 'abstracts/mixins';
     @import 'base/reset';
     @import 'base/typography';
     ```

   - Файл `_reset.scss` будет заполнен стилями сброса, если он был пустым.

## Скриншоты

- **Монтирование:** ![Скриншот монтирования](path/to/mounting-screenshot.png)
- **Запуск в проекте:** ![Скриншот запуска](path/to/running-screenshot.png)
- **Структура файлов:** ![Скриншот структуры файлов](path/to/file-structure-screenshot.png)
