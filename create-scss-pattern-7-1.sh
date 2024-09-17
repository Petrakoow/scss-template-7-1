#!/bin/bash

# Устанавливаем основную директорию для SCSS файлов
parent_dir="scss"
# Файл, в который будут добавлены импорты
connection_file="$parent_dir/main.scss"

script_dir="$(dirname "$(realpath "$BASH_SOURCE")")"

# Массивы директорий и файлов для шаблона
directories=("abstracts" "base" "components" "layout" "pages" "themes" "vendors")
files=(
    "_variables.scss _functions.scss _mixins.scss"  # Файлы для директории abstracts
    "_reset.scss _typography.scss"                 # Файлы для директории base
    ""                                              # Файлы для директории components (пока пусто)
    ""                                              # Файлы для директории layout (пока пусто)
    ""                                              # Файлы для директории pages (пока пусто)
    ""                                              # Файлы для директории themes (пока пусто)
    ""                                              # Файлы для директории vendors (пока пусто)
)

# Создаем основную директорию
mkdir -p "$parent_dir"

# Создаем файл для импорта SCSS
touch "$connection_file"

for i in "${!directories[@]}"; do
    dir="${directories[$i]}"
    mkdir -p "$parent_dir/$dir"
    
    for file in ${files[$i]}; do
        touch "$parent_dir/$dir/$file"

        import_name="${file#_}"     
        import_name="${import_name%.scss}"
        if [ -n "$import_name" ]; then
            if ! grep -q "@import '${dir}/${import_name}';" "$connection_file"; then
                echo "@import '${dir}/${import_name}';" >> "$connection_file"
            fi
        fi
    done
done

# Функция для добавления стилей в файл
add_style() {
    local file_path="$1"
    local style_path="$2"
    
    if [ ! -s "$file_path" ]; then
        if [ -f "$style_path" ]; then
            cat "$style_path" >> "$file_path"
        else
            echo "Style file $style_path does not exist."
        fi
    fi
}

reset_file="$parent_dir/base/_reset.scss"
reset_styles_file="$script_dir/reset-styles.css" 

# Добавляем стили сброса в _reset.scss
add_style "$reset_file" "$reset_styles_file"
