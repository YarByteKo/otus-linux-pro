#!/usr/bin/env bash

# Этот сценарий фиксирует отработку практики по:
#
#    1. Создание отдельного группы томов
#    2. Разметка логического тома
#    3. Перенос корня

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
printf "\n==== Первый этап: подготовка и перемещение корня ====\n\n"

# Фиксация исходной картины
lsblk
pvs
vgs
lvs

# В системе 3 диска, собираю LVM
pvcreate /dev/sdb
vgcreate vg-primary /dev/sdb
lvcreate -n lv-primary -l +100%FREE vg-primary
# Специально размечаю ФС
mkfs.ext4 /dev/vg-primary/lv-primary

pvcreate /dev/sdc
vgextend vg-primary /dev/sdc
vgdisplay vg-primary
# Применение параметра resizefs
lvextend -l +100%FREE -r /dev/vg-primary/lv-primary
vgs vg-primary

mkdir /mnt/vg-primary
mount /dev/vg-primary/lv-primary /mnt/vg-primary/
rsync -axHAX --info=progress2 / /mnt/vg-primary/

ls /mnt/vg-primary/

for i in /proc/ /sys/ /dev/ /run/ /boot/; do
  mount --bind "$i" "/mnt/vg-primary/$i"
done

# Запуск обновления через дочерний процесс для сокращения действий
chroot /mnt/vg-primary/ /bin/bash -e -c 'grub-mkconfig -o /boot/grub/grub.cfg && update-initramfs -u'
# Для информативности вывод
blkid /dev/vg-primary/lv-primary

printf "\n==== Первый этап завершён, перезагрузка сервера ====\n\n"
reboot
