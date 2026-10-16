#!/usr/bin/env bash

# Этот сценарий фиксирует отработку практики по:
#
#    1. Удалению логических томов и групп
#    2. Добавлению в группу нового диска
#    3. Расширению группы  дисков
#    4. Вынесению на RAID1 тома /var
#    5. Созданию снимка /var на оригинальном LVM для эксперимента атомарного перемещения
#    6. Операциям с удерживающими /var процессами
#    7. Автомонтированию
#    8. UUID ФС и DM-UUID

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
printf "\n==== Третий этап: перемещение /var и /home на отдельные тома ====\n\n"

# Удаляю том для создания целевых
lvremove /dev/vg-primary/lv-primary
pvcreate /dev/sdd
vgextend vg-primary /dev/sdd
vgs

# Оставляю резерв для снепшотов
lvcreate --type raid1 -m 1 -L 3G -n raid-var vg-primary
lvcreate -L 3G -n home vg-primary
# Сразу для экспериментов с BTRFS/ZFS
lvcreate -L 3G -n opt vg-primary
vgdisplay
lvs

mkfs.ext4 /dev/vg-primary/raid-var
mkfs.ext4 /dev/vg-primary/home

mkdir -p /mnt/vg-primary/var /mnt/vg-primary/home /mnt/vg-primary/opt /mnt/vg-primary/snap-var
mount /dev/vg-primary/raid-var /mnt/vg-primary/var/

# В процессе переноса задействую снепшот
lvcreate -L 3G -s -n snap-var /dev/ubuntu-vg/ubuntu-lv
mount -o ro /dev/ubuntu-vg/snap-var /mnt/vg-primary/snap-var/

rsync -aHPSAX --info=progress2 /mnt/vg-primary/snap-var/var/ /mnt/vg-primary/var/
rsync -aHPSAX --info=progress2 --delete --exclude='/run/*' --exclude='/lock/*' /var/ /mnt/vg-primary/var/

umount /mnt/vg-primary/var/
mount /dev/vg-primary/raid-var /var

lsof +D /var || true
systemctl restart snap.hwctl.hwctl-daemon.service

blkid /dev/vg-primary/raid-var

VAR_UUID="$(blkid -s UUID -o value /dev/vg-primary/raid-var)"
if [[ -z "$VAR_UUID" ]]; then
  printf "UUID для /dev/vg-primary/raid-var не удалось определить, автомонтирование пропускается\n" >&2
  exit 1
fi

if awk '$1 !~ /^#/ && $2 == "/var" { found=1 } END { exit !found }' /etc/fstab; then
  printf "В /etc/fstab уже есть запись для /var, отмена операции\n" >&2
  exit 1
fi

echo "UUID=$VAR_UUID /var ext4 defaults 0 2" >> /etc/fstab
systemctl daemon-reload
umount /mnt/vg-primary/snap-var/
lvremove -f /dev/ubuntu-vg/snap-var
mount /dev/vg-primary/home /mnt/vg-primary/home/
rsync -aHPSAX --info=progress2 /home/ /mnt/vg-primary/home/
umount /mnt/vg-primary/home/
mount /dev/vg-primary/home /home/
blkid /dev/vg-primary/home

HOME_UUID="$(blkid -s UUID -o value /dev/vg-primary/home)"
if [[ -z "$HOME_UUID" ]]; then
  printf "Не удалось определить UUID /dev/vg-primary/home; /etc/fstab не изменён для /home\n" >&2
  exit 1
fi
if awk '$1 !~ /^#/ && $2 == "/home" { found=1 } END { exit !found }' /etc/fstab; then
  printf "В /etc/fstab уже есть запись для /home, отмена операции записи\n" >&2
  exit 1
fi
echo "UUID=$HOME_UUID /home ext4 defaults 0 2" >> /etc/fstab

printf "\n==== Третий этап завершён, перезагрузка сервера ====\n\n"
reboot
