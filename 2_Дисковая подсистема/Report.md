#### На этом этапе предвартельно добавлены ещё 4 блочных устройства. Все операции выполнялись после отработки RAID-BUILDER.sh на уже готовом и размеченном массиве.

```bash
# Текущая картина
lshw -short | grep disk
```
<details>
<summary><h7>Нажмите, чтобы увидеть вывод</h7></summary>

<pre>/0/100/1.1/0.0.0  /dev/cdrom  <font color="#FF5555"><b>disk</b></font>        CD-ROM
/0/100/d/0        /dev/sda    <font color="#FF5555"><b>disk</b></font>        10GB VBOX HARDDISK
/0/100/d/1        /dev/sdj    <font color="#FF5555"><b>disk</b></font>        1073MB VBOX HARDDISK
/0/100/d/2        /dev/sdb    <font color="#FF5555"><b>disk</b></font>        1073MB VBOX HARDDISK
/0/100/d/3        /dev/sdc    <font color="#FF5555"><b>disk</b></font>        1073MB VBOX HARDDISK
/0/100/d/4        /dev/sdd    <font color="#FF5555"><b>disk</b></font>        1073MB VBOX HARDDISK
/0/100/d/5        /dev/sde    <font color="#FF5555"><b>disk</b></font>        1073MB VBOX HARDDISK
/0/100/d/6        /dev/sdf    <font color="#FF5555"><b>disk</b></font>        1073MB VBOX HARDDISK
/0/100/d/7        /dev/sdg    <font color="#FF5555"><b>disk</b></font>        2147MB VBOX HARDDISK
/0/100/d/8        /dev/sdh    <font color="#FF5555"><b>disk</b></font>        1073MB VBOX HARDDISK
/0/100/d/9        /dev/sdi    <font color="#FF5555"><b>disk</b></font>        1073MB VBOX HARDDISK
</pre>
</details>

```bash
# Имитируем проблему и убираем два диска из массива
mdadm --manage /dev/md0 --fail /dev/sdc /dev/sde
mdadm --manage /dev/md0 --remove /dev/sdc /dev/sde

# Состояние массива
mdadm --detail /dev/md0
```
<details>
<summary><h7>Нажмите, чтобы увидеть вывод</h7></summary>

<pre>/dev/md0:
           Version : 1.2
     Creation Time : Fri Oct  9 16:50:31 2026
        Raid Level : raid6
        Array Size : 3139584 (2.99 GiB 3.21 GB)
     Used Dev Size : 1046528 (1022.00 MiB 1071.64 MB)
      Raid Devices : 5
     Total Devices : 3
       Persistence : Superblock is persistent

     Intent Bitmap : Internal

       Update Time : Sun Oct 11 19:48:35 2026
             State : clean, degraded 
    Active Devices : 3
   Working Devices : 3
    Failed Devices : 0
     Spare Devices : 0

            Layout : left-symmetric
        Chunk Size : 512K

Consistency Policy : bitmap

              Name : Server:0  (local to host Server)
              UUID : 537bb8b5:7f1ce11f:87b98682:32b9172c
            Events : 47

    Number   Major   Minor   RaidDevice State
       0       8       16        0      active sync   /dev/sdb
       -       0        0        1      removed
       5       8       96        2      active sync   /dev/sdg
       -       0        0        3      removed
       4       8       80        4      active sync   /dev/sdf
</pre>
</details>

```bash
# Состояние массива
cat /proc/mdstat
```
<details>
<summary><h7>Нажмите, чтобы увидеть вывод</h7></summary>

<pre>Personalities : [raid4] [raid5] [raid6] 
md0 : active raid6 sdg[5] sdf[4] sdb[0]
      3139584 blocks super 1.2 level 6, 512k chunk, algorithm 2 [5/3] [U_U_U]
      bitmap: 0/1 pages [0KB], 65536KB chunk

unused devices: &lt;none&gt;
</pre>
</details>

```bash
# Добавляем два новых диска
mdadm --manage /dev/md0 --add /dev/sdh /dev/sdi

mdadm: added /dev/sdh
mdadm: added /dev/sdi

# И наблюдаем за ходом пересборки
cat /proc/mdstat

# Или при наличии мультиплексора
watch -n 2 cat /proc/mdstat
```
<details>
<summary><h7>Нажмите, чтобы увидеть вывод</h7></summary>

<pre>Personalities : [raid4] [raid5] [raid6] 
md0 : active raid6 sdi[7] sdh[6] sdg[5] sdf[4] sdb[0]
      3139584 blocks super 1.2 level 6, 512k chunk, algorithm 2 [5/3] [U_U_U]
      [========&gt;............]  recovery = 40.7% (427280/1046528) finish=0.0min speed=142426K/sec
      bitmap: 0/1 pages [0KB], 65536KB chunk

unused devices: &lt;none&gt;
</pre>
</details>

```bash
# Состояние массива
cat /proc/mdstat
```
<details>
<summary><h7>Нажмите, чтобы увидеть вывод</h7></summary>

<pre>Personalities : [raid4] [raid5] [raid6] 
md0 : active raid6 sdi[7] sdh[6] sdg[5] sdf[4] sdb[0]
      3139584 blocks super 1.2 level 6, 512k chunk, algorithm 2 [5/5] [UUUUU]
      bitmap: 0/1 pages [0KB], 65536KB chunk

unused devices: &lt;none&gt;
</pre>
</details>

```bash
# Состояние массива
mdadm --detail /dev/md0
```
<details>
<summary><h7>Нажмите, чтобы увидеть вывод</h7></summary>

<pre>/dev/md0:
           Version : 1.2
     Creation Time : Fri Oct  9 16:50:31 2026
        Raid Level : raid6
        Array Size : 3139584 (2.99 GiB 3.21 GB)
     Used Dev Size : 1046528 (1022.00 MiB 1071.64 MB)
      Raid Devices : 5
     Total Devices : 5
       Persistence : Superblock is persistent

     Intent Bitmap : Internal

       Update Time : Sun Oct 11 20:06:09 2026
             State : clean 
    Active Devices : 5
   Working Devices : 5
    Failed Devices : 0
     Spare Devices : 0

            Layout : left-symmetric
        Chunk Size : 512K

Consistency Policy : bitmap

              Name : Server:0  (local to host Server)
              UUID : 537bb8b5:7f1ce11f:87b98682:32b9172c
            Events : 68

    Number   Major   Minor   RaidDevice State
       0       8       16        0      active sync   /dev/sdb
       7       8      128        1      active sync   /dev/sdi
       5       8       96        2      active sync   /dev/sdg
       6       8      112        3      active sync   /dev/sdh
       4       8       80        4      active sync   /dev/sdf
</pre>
</details>

```bask
lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINTS
```
<details>
<summary><h7>Нажмите, чтобы увидеть вывод</h7></summary>

<pre>NAME        SIZE FSTYPE            MOUNTPOINTS
loop0      66,8M squashfs          /snap/core24/1643
loop1      66,8M squashfs          /snap/core24/2124
loop2       1,5M squashfs          /snap/hwctl/131
loop3       1,5M squashfs          /snap/hwctl/123
loop4      50,1M squashfs          /snap/snapd/27710
sda          10G                   
├─sda1      538M vfat              /boot/efi
└─sda2      9,5G ext4              /
sdb           1G linux_raid_member 
└─md0         3G                   
  ├─md0p1   612M ext4              
  ├─md0p2 613,5M ext4              
  ├─md0p3   612M ext4              
  ├─md0p4 613,5M ext4              
  └─md0p5   612M ext4              
sdc           1G linux_raid_member 
sdd           1G linux_raid_member 
sde           1G linux_raid_member 
sdf           1G linux_raid_member 
└─md0         3G                   
  ├─md0p1   612M ext4              
  ├─md0p2 613,5M ext4              
  ├─md0p3   612M ext4              
  ├─md0p4 613,5M ext4              
  └─md0p5   612M ext4              
sdg           2G linux_raid_member 
└─md0         3G                   
  ├─md0p1   612M ext4              
  ├─md0p2 613,5M ext4              
  ├─md0p3   612M ext4              
  ├─md0p4 613,5M ext4              
  └─md0p5   612M ext4              
sdh           1G linux_raid_member 
└─md0         3G                   
  ├─md0p1   612M ext4              
  ├─md0p2 613,5M ext4              
  ├─md0p3   612M ext4              
  ├─md0p4 613,5M ext4              
  └─md0p5   612M ext4              
sdi           1G linux_raid_member 
└─md0         3G                   
  ├─md0p1   612M ext4              
  ├─md0p2 613,5M ext4              
  ├─md0p3   612M ext4              
  ├─md0p4 613,5M ext4              
  └─md0p5   612M ext4              
sdj           1G                   
sr0        1024M                   
</pre>
</details>

