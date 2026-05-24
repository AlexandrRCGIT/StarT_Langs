#!/bin/bash

SRC="/Users/genius/Library/Application Support/FreesmLauncher/instances/Star Technology/minecraft/kubejs/assets"
DEST="/Users/genius/Desktop/StarT_Langs"

echo "Синхронизация lang-файлов..."

# Копируем все lang/*.json из игры в репо
find "$SRC" -path "*/lang/*.json" | while read file; do
    rel="${file#$SRC/}"
    dest_file="$DEST/$rel"
    mkdir -p "$(dirname "$dest_file")"
    cp "$file" "$dest_file"
done

echo "Файлы скопированы."

# Показываем что изменилось
cd "$DEST"
git status --short

# Спрашиваем сообщение коммита
echo ""
read -p "Сообщение коммита (Enter = пропустить коммит): " msg

if [ -z "$msg" ]; then
    echo "Коммит пропущен."
    exit 0
fi

git add -A
git commit -m "$msg"
git push
echo "Готово!"
