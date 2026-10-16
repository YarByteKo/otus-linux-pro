#!/usr/bin/env bash

# Этот сценарий фиксирует отработку практики по:
#
#    1. Изменение размера логичского тома
#    2. Возвращение корня на оригинальный LVM

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
printf "\n==== Второй этап: уменьшение корня до 8Гб и возвращение в основной LVM ====\n\n"

lsblk -f

lvremove /dev/ubuntu-vg/ubuntu-lv
lvcreate -n ubuntu-lv -L 8G ubuntu-vg
mkfs.ext4 /dev/ubuntu-vg/ubuntu-lv

mkdir /mnt/default-root
mount /dev/ubuntu-vg/ubuntu-lv /mnt/default-root/
rsync -axHAX --info=progress2 / /mnt/default-root/

for i in /proc/ /sys/ /dev/ /run/ /boot/; do
  mount --bind "$i" "/mnt/default-root/$i"
done

chroot /mnt/default-root/ /bin/bash -e -c 'grub-mkconfig -o /boot/grub/grub.cfg && update-initramfs -u'
lsblk -f

printf "\n==== Второй этап завершён, перезагрузка сервера ====\n\n"
reboot
