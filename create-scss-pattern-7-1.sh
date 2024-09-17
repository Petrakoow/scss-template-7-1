#!/bin/bash

# Устанавливаем основную директорию для SCSS файлов
parent_dir="scss"
# Файл, в который будут добавлены импорты
connection_file="$parent_dir/main.scss"

script_dir="$(dirname "$(realpath "$BASH_SOURCE")")"

# Массивы директорий и файлов для шаблона 7-1 
directories=("abstracts" "base" "components" "layout" "pages" "themes" "vendors")
files=(
    "_variables.scss _functions.scss _mixins.scss"  # _partial для директории abstracts (можно перечислять новые части)
    "_reset.scss _typography.scss"                  # _partial для директории base
    ""                                              # _partial для директории components
    ""                                              # _partial для директории layout
    ""                                              # _partial для директории pages 
    ""                                              # _partial для директории themes 
    ""                                              # _partial для директории vendors 
)

# Создаем основную директорию
mkdir -p "$parent_dir"

# Создаем файл для импорта SCSS и добавляем информацию о шаблоне, если файл пустой
if [ ! -s "$connection_file" ]; then
    printf "//This 7-1 template was generated,\n//Details at https://github.com/Petrakoow/scss-template-7-1\n\n" > "$connection_file"
fi

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
