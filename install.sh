#!/bin/bash

# install.sh

set -e

echo "AZXCTEM FASTFETCH CONFIG"
echo "|-> Installing fastfetch (skip if already exists or update)..."

# Установка fastfetch (если не установлен)
if ! command -v fastfetch &> /dev/null; then
    echo "Fastfetch not found, installing..."
    sudo pacman -S --noconfirm fastfetch
else
    echo "Fastfetch already installed, skipping installation..."
fi

echo "|-> Copying config files..."

CONFIG_SOURCE="./config"
CONFIG_TARGET="$HOME/.config/fastfetch"
BACKUP_DIR="$HOME/.config/fastfetch.backup.$(date +%Y%m%d_%H%M%S)"

# Проверяем существование исходной директории с конфигами
if [ ! -d "$CONFIG_SOURCE" ]; then
    echo "Error: Config directory '$CONFIG_SOURCE' not found!"
    echo "Make sure you're running the script from the project root directory"
    exit 1
fi

# Создаем резервную копию существующей конфигурации
if [ -d "$CONFIG_TARGET" ]; then
    echo "|-> Creating backup of existing config..."
    cp -r "$CONFIG_TARGET" "$BACKUP_DIR"
    echo "Backup created: $BACKUP_DIR"

    # Удаляем старую конфигурацию
    rm -rf "$CONFIG_TARGET"
fi

# Создаем целевую директорию и копируем файлы
mkdir -p "$CONFIG_TARGET"
cp -r "$CONFIG_SOURCE"/* "$CONFIG_TARGET/"

echo "|-> Config files copied successfully!"
echo "|-> Fastfetch configuration installed to: $CONFIG_TARGET"
echo "|-> You can now run 'fastfetch' to see the new configuration!"
