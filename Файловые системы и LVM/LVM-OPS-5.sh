#!/usr/bin/env bash

set -Eeuo pipefail

if [[ ${EUID} -ne 0 ]]; then
  printf "Требуется запуск от root $0\n" >&2
  exit 1
fi

LOG_DIR="${LOG_DIR:-/var/log/LVM-OPS}"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/$(basename "$0" .sh).log"
exec > >(tee -a "$LOG_FILE") 2>&1

printf "\nЛог-файл: %s\n\n" "$LOG_FILE"
printf "\n==== Пятый этап: проверка слияния ====\n\n"

cd /home
ls v7.2/amd64/
printf "\n==== Завершено ====\n\n"
