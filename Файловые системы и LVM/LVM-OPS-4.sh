#!/usr/bin/env bash

# Этот сценарий фиксирует отработку практики по:
#
#    1. Рекурсивному скачиванию файлов
#    2. Созданию снимка LVM
#    3. Удаление части файлов
#    4. Восстановление из снимка и его удаление
#    5. Работа с BTRFS на /opt [не готово на момент реквеста]

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
printf "\n==== Четвёртый этап: работа со снимками ====\n\n"

lsblk -f
cd /home/
wget -r -e robots=off -np -nH --cut-dirs=1 -q https://kernel.ubuntu.com/mainline/v7.2/amd64/

lvcreate -L 500MB -s -n snap-test /dev/vg-primary/home

ls v7.2/amd64/
rm -r v7.2/amd64/*.deb
ls v7.2/amd64/

# В ходе практики были процессы, постоянно удерживающие том
# Временная конструкция, чтобы не останавливать скрипт
if umount_output="$(umount /home 2>&1)"; then
  if [[ -n "$umount_output" ]]; then printf '%s\n' "$umount_output"; fi
else
  umount_rc=$?
  printf '%s\n' "$umount_output"
  if grep -qi 'target is busy' <<< "$umount_output"; then
    lvconvert --merge /dev/vg-primary/snap-test
  else
    printf "Отмонтирование /home завершено с кодом %d, завершение без перезагрузки\n" "$umount_rc" >&2
    exit "$umount_rc"
  fi
fi

printf "\n==== Четвёртый этап завершён, перезагрузка для слияния ====\n\n"
reboot
