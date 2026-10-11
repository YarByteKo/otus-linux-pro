#!/usr/bin/env bash

# MVP-сценарий для создания RAID-массива в рамках тестовой среды.
# Для запуска необходимо сделать файл исполняемым, запуск только с правами root.
# Для корректной работы требуется присвоить константам значения, соответствующие тестовой среде.

# Примечание: в профессиональной деятельности для подобной автоматизации использую Python.

set -Eeuo pipefail

# Параметры сценария
RAID_DEVICE="/dev/md0"
RAID_LEVEL=6
RAID_DISKS=(/dev/sdb /dev/sdc /dev/sdd /dev/sde /dev/sdf)
RAID_MOUNT="/raid"
LOG_FILE="/var/log/raid-builder.log"

exec > >(tee -a "$LOG_FILE") 2>&1

printf "\n==========================================\n"
printf "RAID-BUILDER: $(date '+%Y-%m-%d %H:%M:%S')\n"
printf "Лог-файл доступен в: $LOG_FILE"
printf "\n==========================================\n"

printf "\n==== Список блочных устройств ====\n\n"

lshw -short | grep disk || true

for disk in "${RAID_DISKS[@]}"; do
    if [[ ! -b "$disk" ]]; then
        printf "\nОшибка: устройство $disk отсутствует в системе, работа прекращена.\n"
        exit 1
    fi
done

printf "\n==== Выбраны следующие диски для массива: ====\n\n"
printf '  %s\n' "${RAID_DISKS[@]}"

printf "\n==== Создание массива ====\n\n"

mdadm --create "$RAID_DEVICE" \
    --verbose \
    --level="$RAID_LEVEL" \
    --raid-devices="${#RAID_DISKS[@]}" \
    "${RAID_DISKS[@]}"

printf "\n==== Проверка состояния массива ====\n\n"

cat /proc/mdstat
mdadm --detail "$RAID_DEVICE"

printf "\nСинхронизация массива...\n\n"
while grep -qE 'resync|recovery|reshape' /proc/mdstat; do
    cat /proc/mdstat
    sleep 10
done

printf "\nСинхронизация массива завершена.\n"

parted -s "$RAID_DEVICE" mklabel gpt

printf "\n==== Создание разделов ====\n\n"

parted -s "$RAID_DEVICE" mkpart primary ext4 0% 20%
parted -s "$RAID_DEVICE" mkpart primary ext4 20% 40%
parted -s "$RAID_DEVICE" mkpart primary ext4 40% 60%
parted -s "$RAID_DEVICE" mkpart primary ext4 60% 80%
parted -s "$RAID_DEVICE" mkpart primary ext4 80% 100%

partprobe "$RAID_DEVICE"
udevadm settle

parted -s "$RAID_DEVICE" print
lsblk "$RAID_DEVICE"

printf "\n==== Создание файловой системы ====\n\n"

for i in $(seq 1 5); do
    partition="${RAID_DEVICE}p${i}"

    if [[ ! -b "$partition" ]]; then
        printf "\nОшибка: раздел $partition не найден.\n"
        exit 1
    fi
    mkfs.ext4 -F "$partition"
done

printf "\n==== Монтирование разделов ====\n\n"

mkdir -p "$RAID_MOUNT"/disk{1,2,3,4,5}

for i in $(seq 1 5); do
    partition="${RAID_DEVICE}p${i}"
    mount_point="$RAID_MOUNT/part$i"
    mount "$partition" "$mount_point"
    printf "\n$partition смонтирован в $mount_point"
done

printf "\n\n==== ИНФО ====\n\n"

printf "Состояние RAID:\n\n"
cat /proc/mdstat

printf "\nИнформация о массиве:\n\n"
mdadm --detail "$RAID_DEVICE"

printf "\nРазделы и точки монтирования:\n\n"
lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINTS "$RAID_DEVICE"

printf "\nRAID успешно собран.\n\n"
